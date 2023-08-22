import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniapp/dbHelper/constant.dart';
import 'package:uniapp/pages/aspiranVideo.dart';
import 'package:uniapp/screens/aboutUs.dart';
import 'package:uniapp/screens/notification.dart';
import 'package:uniapp/screens/profile.dart';
import 'package:uniapp/screens/program.dart';
import 'package:uniapp/screens/refresh.dart';
import 'package:uniapp/screens/regcourse.dart';
import 'package:uniapp/screens/settings.dart';
import 'package:uniapp/widgets/theme_helper.dart';
import '../repository/apiRepository.dart';
import '../repository/apiRepositoryimplementation.dart';

enum MenuItem { refresh, aboutUs, logOut, becomeAtutor }

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? userType;
  ApiRepository _apiRepository = Get.put(ApiRepositoryImplementation());
  bool visible = false;
  int notificationCounter = 3;
  // late String token;
  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
  }

  _logOut() {
    deleteDbAndDownloads();
  }

  Future deleteDbAndDownloads() async {
    setState(() {
      visible = true;
    });
    await _apiRepository.logOUT().then((value) async {
      if (value == "Logout successfully") {
        Constants.saveUserLoggedInSharedPreference(false);
        setState(() {
          visible = false;
          Get.offAll(Programs());
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 1,
        bottomOpacity: 1.0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "UniApp",
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (() {
                Get.to(Notifications());
              }),
              child: notificationCounter > 0
                  ? Badge(
                      badgeContent: Text(
                        notificationCounter.toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: Icon(
                        Icons.notifications,
                        size: 20,
                      ),
                    )
                  : Icon(
                      Icons.notifications,
                      size: 20,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (() {
                ThemeHelper().swithThemeMode();
              }),
              child: Icon(
                Icons.nightlight_round,
                size: 20,
              ),
            ),
          ),
          PopupMenuButton<MenuItem>(
            onSelected: (MenuItem value) {
              switch (value) {
                case MenuItem.aboutUs:
                  Get.to(Settings());
                  break;

                case MenuItem.refresh:
                  Get.to(Refresh());
                  break;
                case MenuItem.logOut:
                  _logOut();
                  break;

                case MenuItem.becomeAtutor:
                  Get.to(ProfileScreen());
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 40.0,
                value: MenuItem.refresh,
                child: Text(
                  "Refresh Questions",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: MenuItem.becomeAtutor,
                child: Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                height: 40.0,
              ),
              PopupMenuDivider(
                height: 20,
              ),
              PopupMenuItem(
                height: 40.0,
                value: MenuItem.aboutUs,
                child: Text(
                  "Settings",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                height: 40.0,
                value: MenuItem.logOut,
                child: Text(
                  "Log Out",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
        bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            new Tab(icon: Text("PREP")),
            new Tab(icon: Text("Video")),
            new Tab(icon: Text("CBT")),
            // new Tab(icon: Text("CHATS")),
          ],
        ),
      ),
      body: visible
          ? Visibility(
              visible: visible == true,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                ),
              ),
            )
          : new TabBarView(
              controller: _tabController,
              children: <Widget>[
                Regcourse(),
                AspirantVideo(),
                AboutUs(),
                // NewsReader()
              ],
            ),
    );
  }
}
