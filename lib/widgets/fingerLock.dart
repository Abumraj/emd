import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:uniapp/dbHelper/fingerprintDetails.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  @override
  void initState() {
    FingerprintManager().authenticate().then((value) {
      if (value == true) {
        setState(() {
          AppLock.of(context)!.didUnlock();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            child: Icon(
              Icons.fingerprint,
              size: 50,
              color: Colors.white,
            ),
            onPressed: () {
              FingerprintManager().authenticate().then((value) {
                if (value == true) {
                  setState(() {
                    AppLock.of(context)!.didUnlock();
                  });
                }
              });
            },
          ),
          Text(
            "Touch the fingerprint icon",
            style: TextStyle(color: Colors.white),
          )
        ],
      )),
    );
  }
}
