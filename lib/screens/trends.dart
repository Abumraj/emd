import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uniapp/dbHelper/db.dart';
import 'package:uniapp/entities.dart';
import 'package:uniapp/screens/noticeBoard.dart';
import 'package:uniapp/screens/notification.dart';

class CampusTrends extends StatefulWidget {
  const CampusTrends({Key? key}) : super(key: key);

  @override
  State<CampusTrends> createState() => _CampusTrendsState();
}

class _CampusTrendsState extends State<CampusTrends> {
  final storyController = StoryController();
  List<StoryItem> storyItem = [];
  List<Status> university = [
    Status(
        url:
            "The Smoking Tire heads out to Adams Motorsports Park in Riverside, CA to test the most requested car of 2010, the Volkswagen GTI. Will it beat the Mazdaspeed3's standard-setting lap time? Watch and see...",
        type: "1",
        time: DateTime.now(),
        shown: "0",
        level: "u"),
    Status(
        url:
            "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
        type: "2",
        time: DateTime.now(),
        shown: "0",
        level: "u"),
    Status(
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        type: "3",
        time: DateTime.now(),
        shown: "0",
        level: "u")
  ];
  List<Status> department = [];
  List<Status> faculty = [];
  List<Status> other = [];
  List<Status> viewed = [];

  loadRegCourse() async {
    await ObjectBox.deleteStatusAfter24hrs().then((_) {
      ObjectBox.getAllStatus().then((value) {
        value.forEach(
          (element) {
            university.addIf(element.type.toLowerCase() == "u", element);
            faculty.addIf(element.type.toLowerCase() == "f", element);
            department.addIf(element.type.toLowerCase() == "d", element);
            other.addIf(element.type.toLowerCase() == "o", element);
            other.addIf(element.shown == "1", element);
          },
        );
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Campus Trends",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 14.0, bottom: 15.0),
            child: Text(
              "Recent Trends",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Card(
            // margin: EdgeInsets.all(10),
            elevation: 0.2,
            // color: Colors.purple,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              tileColor: Colors.white,
              leading: CircleAvatar(
                radius: 35,
                child: Image.asset("images/uniappLogo.png"),
                backgroundColor: Colors.white,
              ),
              title: Text(
                "University",
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                timeago.format(DateTime.now(), allowFromNow: true),
                style: TextStyle(
                  color: Colors.purple,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                if (university.isNotEmpty) {
                  storyItem = [];
                  university.forEach((e) {
                    if (e.type == 1.toString()) {
                      storyItem.addIf(
                          storyItem.length != university.length,
                          StoryItem.text(
                              title: e.url,
                              backgroundColor: Colors.green,
                              shown: e.shown == "0" ? false : true));
                    } else if (e.type == 2.toString()) {
                      storyItem.addIf(
                          storyItem.length != university.length,
                          StoryItem.pageImage(
                              url: e.url,
                              controller: storyController,
                              caption: e.caption,
                              shown: e.shown == "0" ? false : true));
                    } else {
                      storyItem.addIf(
                          storyItem.length != university.length,
                          StoryItem.pageVideo(e.url,
                              controller: storyController,
                              caption: e.caption,
                              shown: e.shown == "0" ? false : true));
                    }
                  });
                  // print(storyItem.length);
                  Get.to(MoreStories(
                    stor: StoryView(
                      indicatorColor: Colors.purple,
                      storyItems: storyItem,
                      onStoryShow: (s) {
                        print("Showing a story");
                      },
                      onComplete: () {
                        Navigator.pop(context);

                        print("Completed a cycle");
                      },
                      onVerticalSwipeComplete: (d) {
                        if (d == Direction.down) {
                          Navigator.pop(context);
                        } else {
                          storyController.pause();
                          Get.bottomSheet(Notifications());
                        }
                      },
                      progressPosition: ProgressPosition.top,
                      repeat: false,
                      controller: storyController,
                    ),
                  ));
                }
              },
              trailing: Badge(
                badgeColor: Colors.purple,
                elevation: 4,
                badgeContent: Text(
                  university.length.toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // child: Icon(
                //   Icons.notifications,
                //   size: 25,
                // ),
              ),
            ),
          ),
          SizedBox(),
          Card(
            // margin: EdgeInsets.all(10),
            elevation: 0.2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              tileColor: Colors.white,
              leading: CircleAvatar(
                radius: 35,
                child: Image.asset("images/uniappLogo.png"),
                backgroundColor: Colors.white,
              ),
              title: Text(
                "My Department",
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                timeago.format(DateTime.now(), allowFromNow: true),
                style: TextStyle(
                  color: Colors.purple,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                if (department.isNotEmpty) {
                  storyItem = [];
                  department.forEach((e) {
                    if (e.type == 1.toString()) {
                      storyItem.addIf(
                          storyItem.length != department.length,
                          StoryItem.text(
                              title: e.url,
                              backgroundColor: Colors.green,
                              shown: e.shown == "0" ? false : true));
                    } else if (e.type == 2.toString()) {
                      storyItem.addIf(
                          storyItem.length != university.length,
                          StoryItem.pageImage(
                              url: e.url,
                              controller: storyController,
                              caption: e.caption,
                              shown: e.shown == "0" ? false : true));
                    } else {
                      storyItem.addIf(
                          storyItem.length != university.length,
                          StoryItem.pageVideo(e.url,
                              controller: storyController,
                              caption: e.caption,
                              shown: e.shown == "0" ? false : true));
                    }
                  });
                  // print(storyItem.length);
                  Get.to(MoreStories(
                    stor: StoryView(
                      indicatorColor: Colors.purple,
                      storyItems: storyItem,
                      onStoryShow: (s) {
                        print("Showing a story");
                      },
                      onComplete: () {
                        Navigator.pop(context);

                        print("Completed a cycle");
                      },
                      onVerticalSwipeComplete: (d) {
                        if (d == Direction.down) {
                          Navigator.pop(context);
                        } else {
                          storyController.pause();
                          Get.bottomSheet(Notifications());
                        }
                      },
                      progressPosition: ProgressPosition.top,
                      repeat: false,
                      controller: storyController,
                    ),
                  ));
                }
              },
              trailing: Badge(
                badgeColor: Colors.purple,
                elevation: 4,
                badgeContent: Text(
                  department.length.toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // child: Icon(
                //   Icons.notifications,
                //   size: 25,
                // ),
              ),
            ),
          ),
          SizedBox(),
          Card(
            // margin: EdgeInsets.all(10),
            elevation: 0.2,
            // color: Colors.purple,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              tileColor: Colors.white,
              leading: CircleAvatar(
                radius: 35,
                child: Image.asset("images/uniappLogo.png"),
                backgroundColor: Colors.white,
              ),
              title: Text(
                "My Faculty",
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                timeago.format(DateTime.now(), allowFromNow: true),
                style: TextStyle(
                  color: Colors.purple,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                if (faculty.isNotEmpty) {
                  storyItem = [];
                  viewed.forEach((e) {
                    if (e.type == 1.toString()) {
                      storyItem.addIf(
                          storyItem.length != faculty.length,
                          StoryItem.text(
                              title: e.url,
                              backgroundColor: Colors.green,
                              shown: e.shown == "0" ? false : true));
                    } else if (e.type == 2.toString()) {
                      storyItem.addIf(
                          storyItem.length != faculty.length,
                          StoryItem.pageImage(
                              url: e.url,
                              controller: storyController,
                              caption: e.caption,
                              shown: e.shown == "0" ? false : true));
                    } else {
                      storyItem.addIf(
                          storyItem.length != faculty.length,
                          StoryItem.pageVideo(e.url,
                              controller: storyController,
                              caption: e.caption,
                              shown: e.shown == "0" ? false : true));
                    }
                  });
                  // print(storyItem.length);
                  Get.to(MoreStories(
                    stor: StoryView(
                      indicatorColor: Colors.purple,
                      storyItems: storyItem,
                      onStoryShow: (s) {
                        print("Showing a story");
                      },
                      onComplete: () {
                        Navigator.pop(context);

                        print("Completed a cycle");
                      },
                      onVerticalSwipeComplete: (d) {
                        if (d == Direction.down) {
                          Navigator.pop(context);
                        } else {
                          storyController.pause();
                          Get.bottomSheet(Notifications());
                        }
                      },
                      progressPosition: ProgressPosition.top,
                      repeat: false,
                      controller: storyController,
                    ),
                  ));
                }
              },
              trailing: Badge(
                badgeColor: Colors.purple,
                elevation: 4,
                badgeContent: Text(
                  faculty.length.toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // child: Icon(
                //   Icons.notifications,
                //   size: 25,
                // ),
              ),
            ),
          ),
          // SizedBox(),
          Card(
            // margin: EdgeInsets.all(10),
            elevation: 0.2,
            // color: Colors.purple,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              tileColor: Colors.white,
              leading: CircleAvatar(
                radius: 35,
                child: Image.asset("images/uniappLogo.png"),
                backgroundColor: Colors.white,
              ),
              title: Text(
                "General",
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                timeago.format(DateTime.now(), allowFromNow: true),
                style: TextStyle(
                  color: Colors.purple,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                if (other.isNotEmpty) {
                  storyItem = [];
                  other.forEach((e) {
                    if (e.type == 1.toString()) {
                      storyItem.addIf(
                          storyItem.length != other.length,
                          StoryItem.text(
                              title: e.url,
                              backgroundColor: Colors.green,
                              shown: e.shown == "0" ? false : true));
                    } else if (e.type == 2.toString()) {
                      storyItem.addIf(
                          storyItem.length != other.length,
                          StoryItem.pageImage(
                              url: e.url,
                              controller: storyController,
                              caption: e.caption,
                              shown: e.shown == "0" ? false : true));
                    } else {
                      storyItem.addIf(
                          storyItem.length != other.length,
                          StoryItem.pageVideo(e.url,
                              controller: storyController,
                              caption: e.caption,
                              shown: e.shown == "0" ? false : true));
                    }
                  });
                  // print(storyItem.length);
                  Get.to(MoreStories(
                    stor: StoryView(
                      indicatorColor: Colors.purple,
                      storyItems: storyItem,
                      onStoryShow: (s) {
                        print("Showing a story");
                      },
                      onComplete: () {
                        Navigator.pop(context);

                        print("Completed a cycle");
                      },
                      onVerticalSwipeComplete: (d) {
                        if (d == Direction.down) {
                          Navigator.pop(context);
                        } else {
                          storyController.pause();
                          Get.bottomSheet(Notifications());
                        }
                      },
                      progressPosition: ProgressPosition.top,
                      repeat: false,
                      controller: storyController,
                    ),
                  ));
                }
              },
              trailing: Badge(
                badgeColor: Colors.purple,
                elevation: 4,
                badgeContent: Text(
                  other.length.toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // child: Icon(
                //   Icons.notifications,
                //   size: 25,
                // ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 14.0, bottom: 15.0),
            child: Text(
              "Viewed Trends",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Card(
            // margin: EdgeInsets.all(10),
            elevation: 0.2,
            // color: Colors.purple,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              tileColor: Colors.white,
              leading: CircleAvatar(
                radius: 35,
                child: Image.asset("images/uniappLogo.png"),
                backgroundColor: Colors.white,
              ),
              title: Text(
                "Viewed Trends",
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                timeago.format(DateTime.now(), allowFromNow: true),
                style: TextStyle(
                  color: Colors.purple,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                if (viewed.isNotEmpty) {
                  storyItem = [];
                  viewed.forEach((e) {
                    if (e.type == 1.toString()) {
                      storyItem.addIf(
                          storyItem.length != viewed.length,
                          StoryItem.text(
                              title: e.url,
                              backgroundColor: Colors.green,
                              shown: e.shown == "0" ? false : true));
                    } else if (e.type == 2.toString()) {
                      storyItem.addIf(
                          storyItem.length != viewed.length,
                          StoryItem.pageImage(
                              url: e.url,
                              controller: storyController,
                              caption: e.caption,
                              shown: e.shown == "0" ? false : true));
                    } else {
                      storyItem.addIf(
                          storyItem.length != viewed.length,
                          StoryItem.pageVideo(e.url,
                              controller: storyController,
                              caption: e.caption,
                              shown: e.shown == "0" ? false : true));
                    }
                  });
                  // print(storyItem.length);
                  Get.to(MoreStories(
                    stor: StoryView(
                      indicatorColor: Colors.purple,
                      storyItems: storyItem,
                      onStoryShow: (s) {
                        print("Showing a story");
                      },
                      onComplete: () {
                        Navigator.pop(context);

                        print("Completed a cycle");
                      },
                      onVerticalSwipeComplete: (d) {
                        if (d == Direction.down) {
                          Navigator.pop(context);
                        } else {
                          storyController.pause();
                          Get.bottomSheet(Notifications());
                        }
                      },
                      progressPosition: ProgressPosition.top,
                      repeat: false,
                      controller: storyController,
                    ),
                  ));
                }
              },
              trailing: Badge(
                badgeColor: Colors.purple,
                elevation: 4,
                badgeContent: Text(
                  viewed.length.toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // child: Icon(
                //   Icons.notifications,
                //   size: 25,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
