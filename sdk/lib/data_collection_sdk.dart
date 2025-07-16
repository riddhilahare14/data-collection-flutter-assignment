import 'dart:convert';
import 'package:http/http.dart' as http;

/// Public SDK class
class DataCollectionSDK {
  final String apiUrl;
  final List<Map<String, dynamic>> _buffer = [];

  DataCollectionSDK({required this.apiUrl});

  /// Call once to initialize (pass backend URL)
  static DataCollectionSDK initialize({required String apiUrl}) {
    return DataCollectionSDK(apiUrl: apiUrl);
  }

  /// Pass SMS event here
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

  /// Pass Call Log event here
  Future<void> trackCallLog(Map<String, dynamic> callLogEvent) async {
    print('📞 Received Call Log event: $callLogEvent');
    _buffer.add(callLogEvent);

    if (_buffer.length >= 50) {
      print('🚀 Buffer size 50 reached. Flushing.');
      await _flushBuffer();
    }
  }

  /// Check if SMS body contains transactional keywords
  bool _isTransactional(String body) {
    final lowerBody = body.toLowerCase();
    final keywords = ['otp', 'transaction', 'debited', 'credited', 'spent'];
    return keywords.any((kw) => lowerBody.contains(kw));
  }

  /// Send immediately or flush buffer
  Future<void> _sendToBackend(List<Map<String, dynamic>> payload) async {
    final response = await http.post(
      Uri.parse('$apiUrl/v1/events'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    print('Backend responded with status: ${response.statusCode}');
  }

  /// Flush all buffered events
  Future<void> _flushBuffer() async {
    if (_buffer.isEmpty) return;
    await _sendToBackend(_buffer);
    _buffer.clear();
  }
}
