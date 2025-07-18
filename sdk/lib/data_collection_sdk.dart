import 'dart:convert';
import 'package:http/http.dart' as http;

class DataCollectionSDK {
  final String apiUrl;
  final List<Map<String, dynamic>> _buffer = [];

  DataCollectionSDK({required this.apiUrl});

  static DataCollectionSDK initialize({required String apiUrl}) {
    return DataCollectionSDK(apiUrl: apiUrl);
  }

  Future<void> trackSms(Map<String, dynamic> smsEvent) async {
    print('📩 Received SMS event: $smsEvent');

    if (_isTransactional(smsEvent['body'] ?? '')) {
      print('🔔 Detected transactional SMS. Sending immediately.');
      await _sendToBackend([smsEvent]);
    } else {
      _buffer.add(smsEvent);
      if (_buffer.length >= 50) {
        print('🚀 Buffer size 50 reached. Flushing.');
        await _flushBuffer();
      }
    }
  }

  Future<void> trackCallLog(Map<String, dynamic> callLogEvent) async {
    print('📞 Received Call Log event: $callLogEvent');
    _buffer.add(callLogEvent);

    if (_buffer.length >= 50) {
      print('🚀 Buffer size 50 reached. Flushing.');
      await _flushBuffer();
    }
  }

  bool _isTransactional(String body) {
    final lowerBody = body.toLowerCase();
    final keywords = ['otp', 'transaction', 'debited', 'credited', 'spent'];
    return keywords.any((kw) => lowerBody.contains(kw));
  }

  Future<void> _sendToBackend(List<Map<String, dynamic>> payload) async {
    final response = await http.post(
      Uri.parse('$apiUrl/v1/events'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    print('Backend responded with status: ${response.statusCode}');
  }

  Future<void> _flushBuffer() async {
    if (_buffer.isEmpty) return;
    await _sendToBackend(_buffer);
    _buffer.clear();
  }
}
