import 'package:flutter/material.dart';

// prevent app from minimizing

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Return the app to the active state
        AppLifecycleState activeState = AppLifecycleState.resumed;
        WidgetsBinding.instance.handleAppLifecycleStateChanged(activeState);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prevent App Lifecycle Change',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Prevent App Lifecycle Change'),
        ),
        body: Center(
          child: Text(
            'Your app content goes here',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
