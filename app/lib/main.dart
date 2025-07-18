import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sdk/data_collection_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _smsPermission = false;
  final List<String> _log = [];
  late DataCollectionSDK sdk;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    sdk = DataCollectionSDK.initialize(apiUrl: 'http://10.0.2.2:8000');

    var status = await Permission.sms.request();
    setState(() {
      _smsPermission = status.isGranted;
    });

    if (_smsPermission) {
      _log.add('✅ SMS Permission Granted');

      for (int i = 0; i < 55; i++) {
        final sms = {
          'id': i,
          'body': i % 10 == 0 ? 'Your OTP is 1234' : 'Hi, this is normal SMS'
        };
        final callLog = {'id': i, 'number': '+1234567890'};

        await sdk.trackSms(sms);
        _log.add('Sent SMS #$i to SDK');

        await sdk.trackCallLog(callLog);
        _log.add('Sent Call Log #$i to SDK');
      }
      setState(() {});
    } else {
      _log.add('❌ SMS Permission Denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Data Collection App')),
        body: Column(
          children: [
            ListTile(
              title: Text('SMS Permission:'),
              subtitle: Text(_smsPermission ? 'Granted' : 'Denied'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _log.length,
                itemBuilder: (_, i) => ListTile(title: Text(_log[i])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
