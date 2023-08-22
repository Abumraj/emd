import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniapp/models/testModel.dart';
import 'package:uniapp/repository/apiRepositoryimplementation.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uniapp/widgets/testRoom.dart';
import 'package:uniapp/widgets/theme_helper.dart';
import '../repository/apiRepository.dart';

class TestBuildUp extends StatefulWidget {
  final String? coursecode;
  final int? courseId;
  const TestBuildUp({Key? key, this.coursecode, this.courseId})
      : super(key: key);

  @override
  State<TestBuildUp> createState() => _TestBuildUpState();
}

class _TestBuildUpState extends State<TestBuildUp> {
  ApiRepository _apiRepository = Get.put(ApiRepositoryImplementation());
  List<TestChapter> chapter = [];
  bool isLoading = false;
  Map<int, String> weekDayName = {
    1: "Mon",
    2: "Tue",
    3: "Wed",
    4: "Thur",
    5: "Fri",
    6: "Sat",
    7: "Sun",
  };
  Map<int, String> monthName = {
    1: "JAN",
    2: "FEB",
    3: "MAR",
    4: "APR",
    5: "MAY",
    6: "JUN",
    7: "JUL",
    8: "AUG",
    9: "SEPT",
    10: "OCT",
    11: "NOV",
    12: "DEC"
  };

  @override
  void initState() {
    loadChapter();
    super.initState();
  }

  loadChapter() async {
    setState(() {
      isLoading = true;
    });

    final result =
        await _apiRepository.getTestChapter(widget.courseId.toString());
    if (result.isNotEmpty) {
      setState(() {
        chapter = result;
        isLoading = false;
      });
    }
  }

  checkApprovalStatus(int chapterId, String chapterName, int chapterNum,
      int chapterTime, chapterStartTime) async {
    String? message;
    setState(() {
      isLoading = true;
    });
    await _apiRepository.saveToken(chapterId).then((value) {
      setState(() {
        message = value.toString();
        isLoading = false;
      });
    });
    if (message != null) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            title: new Text(
              message!.toUpperCase(),
              style: TextStyle(
                // color: Colors.green,
                fontSize: 15.00,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
            ),
            content: message == "approved"
                ? Text(
                    "Congratulations! You have been Approved to take this test. kindly do away with any implicative materials before proceeding to the exam hall",
                    style: TextStyle(color: Colors.green))
                : message == "not approved"
                    ? Text(
                        "You have not been Approved to take this test. Please check bsck later.",
                        style: TextStyle(color: Colors.red))
                    : Text(
                        "Sorry, you can not do a test multiple times",
                        style: TextStyle(color: Colors.red),
                      ),
            actions: <Widget>[
              message == "approved"
                  ? TextButton(
                      child: new Text(
                        "Enter Exam Hall",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                          return Colors.green;
                        }),
                      ),
                      onPressed: () {
                        Navigator.pop(context);

                        Get.to(WaitRoom(
                          testName: chapterName,
                          questTime: chapterTime,
                          questNum: chapterNum,
                          testStartTime: chapterStartTime,
                          testId: chapterId,
                        ));
                      },
                    )
                  : TextButton(
                      child: new Text("Back"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple,
          title: Text(widget.coursecode.toString().toUpperCase()),
          elevation: 0,
        ),
        body: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: chapter.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  DateTime d = DateTime.parse(chapter[index].startTime!);
                  TimeOfDay t = TimeOfDay(hour: d.hour, minute: d.minute);
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                        // color: Colors.white,
                        elevation: 0.2,
                        shadowColor: Colors.purple,
                        child: Column(
                          children: [
                            ListTile(
                                leading: CircleAvatar(
                                  child: Image.asset("images/uniappLogo.png"),
                                  backgroundColor: Colors.white,
                                ),
                                title: Text(
                                    chapter[index].chapterName.toString(),
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 16.0,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold)),
                                subtitle: DateTime.parse(
                                            chapter[index].endTime.toString())
                                        .isAfter(DateTime.now())
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Date: ${weekDayName[d.weekday]}, ${monthName[d.month]}  ${d.day}  (${timeago.format(DateTime.parse(chapter[index].startTime.toString()).subtract(Duration(minutes: 30)), allowFromNow: true)})",
                                              style: TextStyle(
                                                  // color: Colors.purple,
                                                  fontSize: 12.0,
                                                  // fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              "Time: ${t.format(context)} ${t.period.name}",
                                              style: TextStyle(
                                                  // color: Colors.purple,
                                                  fontSize: 15.0,
                                                  // fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              "Lecturer: ${chapter[index].lecturer} ",
                                              style: TextStyle(
                                                // color: Colors.purple,
                                                fontSize: 12.0,
                                                fontStyle: FontStyle.italic,
                                                // fontWeight: FontWeight.bold
                                              )),
                                        ],
                                      )
                                    : Text(
                                        "Ended ${timeago.format(DateTime.parse(chapter[index].endTime.toString()), allowFromNow: true)}",
                                        style: TextStyle(
                                          color: Colors.red,
                                          // fontSize: 12.0,
                                          // fontStyle: FontStyle.italic,
                                          // fontWeight: FontWeight.bold
                                        )),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Text(
                                          chapter[index].marks.toString() ==
                                                  "null"
                                              ? "Unknown mark"
                                              : "${chapter[index].marks} marks",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16.0,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Text(chapter[index].description!,
                                        style: TextStyle(
                                            // color: Colors.green,
                                            fontSize: 16.0,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                onTap: () {
                                  if (DateTime.parse(
                                          chapter[index].endTime.toString())
                                      .isBefore(DateTime.now())) {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alartDialog(
                                              "Ooops",
                                              "This ${chapter[index].description} has ended ${timeago.format(DateTime.parse(chapter[index].endTime.toString()), allowFromNow: true)}",
                                              context);
                                        });
                                  } else if (DateTime.parse(
                                          chapter[index].startTime.toString())
                                      .isBefore(DateTime.now()
                                          .add(Duration(minutes: 30)))) {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alartDialog(
                                              "Wait!",
                                              "Not yet time. Please check back ${timeago.format(DateTime.parse(chapter[index].startTime.toString()), allowFromNow: true)} ",
                                              context);
                                        });
                                  } else {
                                    checkApprovalStatus(
                                      chapter[index].chapterId!.toInt(),
                                      chapter[index].chapterName!.toString(),
                                      chapter[index].quesNum!.toInt(),
                                      chapter[index].quesTime!.toInt(),
                                      chapter[index].startTime!,
                                    );
                                  }
                                }),
                          ],
                        )),
                  );
                },
              ));
  }
}
