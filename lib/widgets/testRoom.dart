import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uniapp/models/questionModel.dart';
import 'package:uniapp/repository/apiRepository.dart';
import 'package:uniapp/repository/apiRepositoryimplementation.dart';
import 'package:uniapp/widgets/testDialog.dart';
import 'package:uniapp/widgets/theme_helper.dart';

class WaitRoom extends StatefulWidget {
  final testName;
  final testId;
  final questNum;
  final testStartTime;
  final questTime;
  const WaitRoom(
      {Key? key,
      @required this.testName,
      @required this.questNum,
      @required this.questTime,
      @required this.testStartTime,
      @required this.testId})
      : super(key: key);

  @override
  State<WaitRoom> createState() => _WaitRoomState();
}

class _WaitRoomState extends State<WaitRoom> {
  ApiRepository _apiRepository = Get.put(ApiRepositoryImplementation());

  List<Question> questions = [];
  bool isLoading = false;

  loadQuestion(int chapterId, chapterName, quesNum, quesTime) async {
    print(chapterId);
    setState(() {
      isLoading = true;
    });
    final result = await _apiRepository.getTestQuestions(chapterId);
    if (result.isNotEmpty) {
      setState(() {
        questions = result;
        isLoading = false;
      });
      Get.bottomSheet(TestOptionDialog(
        questions: questions,
        chapterName: chapterName,
        chapterId: chapterId,
        quesNum: quesNum,
        quesTime: quesTime,
      ));
    } else {
      setState(() {
        // questions = result;
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (
            BuildContext context,
          ) {
            return ThemeHelper().alartDialog(
                "Ooops",
                "Questions currently not available. Contact your lecturer",
                context);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.purple,
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 50),
                  child: Text(
                    widget.testName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: CircleAvatar(
                    child: Image.asset("images/uniappLogo.png"),
                    backgroundColor: Colors.white,
                    radius: 80,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "STARTS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      timeago.format(
                          DateTime.parse(widget.testStartTime.toString()),
                          allowFromNow: true),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)),
                ),
                if (DateTime.parse(widget.testStartTime.toString()) ==
                        DateTime.now() ||
                    DateTime.parse(widget.testStartTime.toString())
                        .isAfter(DateTime.now()))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
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
                          })),
                      child: new Text("Continue"),
                      onPressed: () async {
                        _apiRepository.startTest(widget.testId).then((value) {
                          if (value == "false") {
                            setState(() {
                              showDialog(
                                  context: context,
                                  builder: ((BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      title: new Text(
                                        "Alert!",
                                        style: TextStyle(
                                          // color: Colors.green,
                                          fontSize: 15.00,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      content: new Text(
                                        "Wait for permission to start",
                                        style: TextStyle(
                                          // color: Colors.green,
                                          fontSize: 20.00,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    );
                                  }));
                            });
                          } else if (value == "true") {
                            loadQuestion(widget.testId, widget.testName,
                                widget.questNum, widget.questTime);
                          }
                        });
                      },
                    ),
                  ),
              ],
            ),
    );
  }
}
