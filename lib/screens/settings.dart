import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniapp/dbHelper/constant.dart';
import 'package:uniapp/dbHelper/fingerprintDetails.dart';
import 'package:uniapp/screens/notification.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isFingerprintEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadFingerprintEnabled();
  }

  Future<void> _loadFingerprintEnabled() async {
    final isEnabled = await Constants.isFingerprintEnabled();
    setState(() {
      _isFingerprintEnabled = isEnabled;
    });
  }

  Future<void> _toggleFingerprintEnabled(bool value) async {
    if (value == true) {
      await Constants.setFingerprintEnabled(value);
      FingerprintManager().authenticate().then((value1) {
        if (value1 == true) {
          setState(() {
            _isFingerprintEnabled = value;
          });
        }
      });
    } else {
      setState(() {
        _isFingerprintEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          Card(
            child: SwitchListTile(
              title: Text('Unlock with Fingerprint'),
              subtitle: Text(
                  "When enabled, you will need to use fingerprint to open UniApp."),
              value: _isFingerprintEnabled,
              onChanged: (value) async {
                await _toggleFingerprintEnabled(value);
              },
            ),
          ),
          Container(
            child: ListTile(
              onTap: (() {
                Get.to(Notifications());
              }),
              title: Text("Notifications"),
            ),
          )
        ],
      ),
    );
  }
}
