import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniapp/Services/uapi.dart';
import '../dbHelper/db.dart';
import '../entities.dart';
import '../widgets/courseHeader.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  List<FirebaseLocalNotification> regCourse = [];
  bool isLoading = false;
  bool isFlutterLocalNotificationsInitialized = false;
  @override
  void initState() {
    super.initState();
    initInfo();
    loadRegCourse();
  }

  loadRegCourse() async {
    setState(() {
      isLoading = true;
    });
    final result = await ObjectBox.getAllNotification();
    setState(() {
      isLoading = false;
      if (result.isEmpty) {
        regCourse = [
          FirebaseLocalNotification(
              dataTitle: "How to register for jupeb ",
              isLive: DateTime.now().toIso8601String(),
              dataBody:
                  "Jupeb registeration involves registering for alot of exams starting from day one.",
              dataLink: "https:unilorin.edu.ng"),
          FirebaseLocalNotification(
              dataTitle: "How to register for jupeb ",
              isLive: DateTime.now().toIso8601String(),
              dataBody:
                  "Jupeb registeration involves registering for alot of exams starting from day one.",
              dataLink: "https:unilorin.edu.ng"),
          FirebaseLocalNotification(
            dataTitle: "How to register for jupeb ",
            isLive: DateTime.now().toIso8601String(),
            dataBody:
                "Jupeb registeration involves registering for alot of exams starting from day one.",
            // dataLink: "https:unilorin.edu.ng"
          ),
          FirebaseLocalNotification(
              dataTitle: "How to register for jupeb ",
              isLive: DateTime.now().toIso8601String(),
              dataBody:
                  "Jupeb registeration involves registering for alot of exams starting from day one.",
              dataLink: "https:unilorin.edu.ng"),
          FirebaseLocalNotification(
              isLive: DateTime.now().toIso8601String(),
              dataTitle: "How to register for jupeb ",
              dataBody:
                  "Jupeb registeration involves registering for alot of exams starting from day one.",
              dataLink: "https:unilorin.edu.ng"),
        ];
      } else {
        regCourse = result;
      }
    });
  }

  void initInfo() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      var noteTime = message.sentTime!.toIso8601String();
      await ObjectBox.saveNotification(
        noteTime,
        message.data["dataTitle"],
        message.data["dataLink"],
        message.data["dataBody"],
        message.data["dataImageLink"],
      );
    });
    if (isFlutterLocalNotificationsInitialized) {
      return;
    } else {
      await FlutterNotificationChannel.registerNotificationChannel(
        description: 'This is AbumRaj channel',
        id: 'abumraj',
        importance: NotificationImportance.IMPORTANCE_HIGH,
        name: 'abumraj',
      );
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      setState(() {
        isFlutterLocalNotificationsInitialized = true;
      });
    }
  }

  Widget nView() {
    return Stack(
      children: [
        Container(
          height: 150,
          child: HeaderWidget1(150, true, "News"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          : regCourse.isEmpty
              ? Center(
                  child: Text(
                    "No News yet",
                    style: TextStyle(color: Colors.purple, fontSize: 15),
                  ),
                )
              : ListView.builder(
                  itemCount: regCourse.length,
                  itemBuilder: (BuildContext context, int index) {
                    FirebaseLocalNotification reader = regCourse[index];
                    return Card(
                      child: ExpansionTile(
                        // isThreeLine: true,
                        expandedAlignment: Alignment.center,
                        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                        trailing: SizedBox(
                          width: 40,
                          child: Text(
                            timeago.format(
                                DateTime.parse(reader.isLive.toString()),
                                allowFromNow: true),
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ),
                        title: Text(
                          reader.dataTitle.toString(),
                          style: TextStyle(
                              color: Colors.purple,
                              // fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          reader.dataBody.toString(),
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: TextStyle(color: Colors.purple),
                        ),
                        leading: SizedBox(
                          width: 55,
                          child: CachedNetworkImage(
                            imageUrl: "reader.dataImageLink!",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                                child: const CircularProgressIndicator(
                              color: Colors.purple,
                            )),
                            errorWidget: (context, url, error) => CircleAvatar(
                              child: Image.asset("images/uniappLogo.png"),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 4),
                              child: Text(
                                reader.dataBody.toString(),
                                // strutStyle: StrutStyle(),
                                textAlign: TextAlign.justify,
                                style: context.textTheme.bodyText1,
                              )),
                          const SizedBox(height: 4),
                          if (reader.dataLink.toString() != "null")
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 4.0, left: 4.0, right: 4.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Uapi.openChromeSafariBrowser(reader.dataLink);
                                },
                                child: const Text('Read More...'),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
    );
  }
}
