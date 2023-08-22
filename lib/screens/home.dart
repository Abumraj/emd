import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:uniapp/Services/uapi.dart';
import 'package:uniapp/dbHelper/db.dart';
import 'package:uniapp/screens/departmentSelecton.dart';
import 'package:uniapp/screens/mainscreen.dart';
import 'package:uniapp/screens/phone.dart';
import 'package:uniapp/screens/trends.dart';
import 'package:uniapp/screens/unitrans.dart';
import 'package:uniapp/widgets/gpapage.dart';

// class CumstomClip extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     //  ..arcTo(path/2)
//     return path;

//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  List<Widget> screens = [
    MainScreen(),
    StalHome(),
    UniTrans(),
    PhoneSecurity()
  ];
  String? userType;
  int statusCount = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentPage = MainScreen();
  Widget secure() {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text("data"),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ObjectBox.statusCount().then((value) => statusCount = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentPage),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        heroTag: null,
        child: CircleAvatar(
          child: Image.asset("images/uniappLogo.png"),
          backgroundColor: Colors.white,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentPage = MainScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0
                              ? Colors.purpleAccent
                              : Colors.purple,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: currentTab == 0
                                ? Colors.purpleAccent
                                : Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        Uapi.openChromeSafariBrowser(
                            "https://uilugportal.unilorin.edu.ng");
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: currentTab == 1
                              ? Colors.purpleAccent
                              : Colors.purple,
                        ),
                        Text(
                          "Portal",
                          style: TextStyle(
                            color: currentTab == 1
                                ? Colors.purpleAccent
                                : Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentPage = GPA();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calculate,
                          color: currentTab == 2
                              ? Colors.purpleAccent
                              : Colors.purple,
                        ),
                        Text(
                          "GPA",
                          style: TextStyle(
                            color: currentTab == 2
                                ? Colors.purpleAccent
                                : Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentPage = CampusTrends();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Badge(
                          badgeColor: Colors.purple,
                          badgeContent: Text(
                            statusCount.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          child: Icon(
                            Icons.speaker_phone,
                            color: currentTab == 3
                                ? Colors.purpleAccent
                                : Colors.purple,
                          ),
                        ),
                        Text(
                          "DNB",
                          style: TextStyle(
                            color: currentTab == 3
                                ? Colors.purpleAccent
                                : Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
