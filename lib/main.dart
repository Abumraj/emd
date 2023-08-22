import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniapp/dbHelper/db.dart';
import 'package:uniapp/screens/home.dart';
import 'package:uniapp/screens/welcome.dart';
import 'package:uniapp/widgets/badCert.dart';
import 'package:uniapp/widgets/fingerLock.dart';
import 'package:uniapp/widgets/theme.dart';
import 'dbHelper/constant.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';

@pragma('vm:entry-point')
late ObjectBox objectBox;
late SharedPreferences saveLocal;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await ObjectBox.saveNotification(
    message.sentTime!.toIso8601String(),
    message.data["dataTitle"],
    message.data["dataLink"],
    message.data["dataBody"],
    message.data["dataImageLink"],
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  bool? isLoggedIn = false;
  saveLocal = await SharedPreferences.getInstance();

  objectBox = await ObjectBox.create();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FlutterDownloader.initialize(debug: false);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
  await Constants.getUerLoggedInSharedPreference().then((value) {
    isLoggedIn = value;
  });

  runApp(AppLock(
    builder: (arg) => Uniapp(
      isLoggedIn: isLoggedIn,
    ),
    lockScreen: LockScreen(),
    enabled: true,
  ));
}

class Uniapp extends StatefulWidget {
  final bool? isLoggedIn;

  const Uniapp({@required this.isLoggedIn});

  @override
  _UniappState createState() => _UniappState();
}

class _UniappState extends State<Uniapp> {
  bool isLightMode = true;
  bool? isLoggedIn = false;
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);

  //   if (state == AppLifecycleState.resumed) {
  //     // App has resumed from the background, trigger fingerprint authentication
  //     FingerprintManager().authenticate();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      title: 'UniApp',
      theme: Themes.light,
      themeMode: ThemeMode.light,
      darkTheme: Themes.dark,
      getPages: [
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/Welcome", page: () => Welcome()),
      ],
      initialRoute: widget.isLoggedIn == true ? "/home" : "/Welcome",
    );
  }
}
