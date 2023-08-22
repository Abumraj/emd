import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniapp/dbHelper/fingerprintDetails.dart';
import 'package:uniapp/screens/highscore.dart';
import 'package:uniapp/screens/postUtme.dart';
import 'package:uniapp/screens/refresh.dart';
import 'package:uniapp/widgets/courseHeader.dart';
import 'package:uniapp/widgets/hexColor.dart';
import 'package:uniapp/widgets/theme_helper.dart';
import '../Services/uapi.dart';
import '../dbHelper/db.dart';
import '../entities.dart';

class Regcourse extends StatefulWidget {
  Regcourse({Key? key}) : super(key: key);

  @override
  State<Regcourse> createState() => _RegcourseState();
}

class _RegcourseState extends State<Regcourse> {
  List<RegCourse> regCourse = [];
  List<HighScore> highScore = [];
  bool isLoading = false;
  int index = 0;
  String? userType;
  @override
  void initState() {
    loadRegCourse();
    super.initState();
  }

  loadRegCourse() async {
    setState(() {
      isLoading = true;
    });
    final result = await ObjectBox.getAllRegCourse();
    setState(() {
      isLoading = false;
      regCourse = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          : view(),
    ));
  }

  Widget view() {
    return Stack(children: <Widget>[
      Container(
        height: 150,
        child:
            HeaderWidget1(150, regCourse.isEmpty ? true : false, "My Courses"),
      ),
      regCourse.isEmpty
          ? Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 18, 17, 19),
                        offset: Offset(0, 4),
                        blurRadius: 5.0)
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      HexColor("#DC54FE"),
                      HexColor("#8A02AE"),
                    ],
                  ),
                  color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  style: ThemeHelper().buttonStyle(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: Text(
                      "Load Course",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.to(Refresh());
                  },
                ),
              ),
            )
          : Container(
              child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.9),
              itemBuilder: (BuildContext context, int index) {
                var courseVideo = regCourse[index];
                print(courseVideo.courseId);
                return SingleProt(
                  link: courseVideo.courseChatLink!,
                  id: courseVideo.courseId!.toInt(),
                  code: courseVideo.coursecode.toString(),
                  description: courseVideo.courseName.toString(),
                  expireAt: courseVideo.expireAt.toString(),
                  progress: courseVideo.progress!,
                  unit: courseVideo.courseImage.toString(),
                  status: courseVideo.courseDescrip!,
                );
              },
              itemCount: regCourse.length,
            )),
    ]);
  }
}

class SingleProt extends StatelessWidget {
  final int id;
  final String code;
  final String unit;
  final String status;
  final String link;
  final String description;
  final String expireAt;
  final int progress;

  SingleProt(
      {required this.id,
      required this.code,
      required this.description,
      required this.expireAt,
      required this.progress,
      required this.unit,
      required this.status,
      required this.link});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
      child: MaterialButton(
          padding: EdgeInsets.zero,
          height: 60,
          splashColor: Colors.purple,
          elevation: 2.0,
          onPressed: () {
            Get.to(PostUtme(coursecode: code, courseId: id));
          },
          onLongPress: () {
            FingerprintManager().authenticate().then((value) {
              if (value == true) {
                Get.bottomSheet(
                    CourseProgress(
                      coursecode: code,
                    ),
                    isScrollControlled: true,
                    enterBottomSheetDuration: Duration(seconds: 2));
              }
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.grey.shade800,
          textColor: Colors.white70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.video_collection,
                size: 30,
                color: Colors.white,
              ),
              SizedBox(height: 8.0),
              Text(
                code,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
                textAlign: TextAlign.center,
                maxLines: 7,
              ),
              SizedBox(height: 8.0),
              Text(
                description.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 10),
                textAlign: TextAlign.center,
                maxLines: 7,
              ),
              SizedBox(height: 8.0),
              Text(
                status.toLowerCase() == "r"
                    ? "Required"
                    : status.toLowerCase() == "c"
                        ? "Compulsory"
                        : status.toLowerCase() == "e"
                            ? "Elective"
                            : "Carry Over",
                style: TextStyle(
                    color: status.toLowerCase() == "c" ||
                            status.toLowerCase() == "r"
                        ? Colors.green
                        : status.toLowerCase() == "e"
                            ? Colors.yellow
                            : Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 10),
                textAlign: TextAlign.center,
                maxLines: 7,
              ),
              SizedBox(height: 8.0),
              Text(
                "$unit Units",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 10),
                textAlign: TextAlign.center,
                maxLines: 7,
              ),
              // SizedBox(height: 8.0),
              SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: TextButton(
                      onPressed: (() {
                        Uapi.joinTelegramGroupChat(link, true);
                      }),
                      child: Text("Join Group Chat"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                          return Colors.green; // Use the default value.
                        }),
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                          return Colors.white; // Use the default value.
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    child: LinearProgressIndicator(
                      color: Colors.green,
                      backgroundColor: Colors.white,
                      value: progress / 100,
                      semanticsLabel: "$progress%",
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
