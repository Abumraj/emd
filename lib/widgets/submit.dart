import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:uniapp/models/questionModel.dart';
import 'package:uniapp/repository/apiRepository.dart';
import 'package:uniapp/repository/apiRepositoryimplementation.dart';
import 'package:uniapp/screens/home.dart';

class Submit extends StatefulWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;
  final String chapterName;
  final chapterId;
  final courseId;
  const Submit(
      {Key? key,
      required this.questions,
      required this.answers,
      required this.chapterName,
      this.chapterId,
      this.courseId})
      : super(key: key);

  @override
  State<Submit> createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  ApiRepository _apiRepository = Get.put(ApiRepositoryImplementation());

  bool isLoading = false;
  int correct = 0;
  int percent = 0;
  String? message;
  saveBot() async {
    widget.answers.forEach((index, value) {
      if (this.widget.questions[index].option1 == value) {
        correct++;
      }

      // percent = (correct / widget.questions.length * 100).ceil();
      print(correct);
    });
    sendAndSaveResult();
  }

  sendAndSaveResult() async {
    print(correct);
    setState(() {
      isLoading = true;
    });
    await _apiRepository
        .postTestResult(widget.chapterId, correct)
        .then((value) {
      print(value);
      setState(() {
        message = value.toString();
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // isLoading = true;
    saveBot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'You Cannot go back to the Test screen',
                style: TextStyle(color: Colors.purple, fontSize: 17),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Material(
          color: Theme.of(context).primaryColor,
          child: message == "Submitted"
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Badge(
                        toAnimate: true,
                        shape: BadgeShape.circle,
                        badgeColor: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        animationType: BadgeAnimationType.scale,
                        badgeContent: Icon(
                          Icons.file_download_done,
                          size: 120,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    AnimatedTextKit(repeatForever: false, animatedTexts: [
                      TyperAnimatedText(
                        "SUBMITTED SUCCESFULLY",
                        textStyle: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 32.0),
                        speed: const Duration(milliseconds: 100),

                        // duration: Duration(seconds: 10),
                      ),
                    ]),
                    TextButton(
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
                      onPressed: () {
                        Get.offAll(Home());
                      },
                      child: Text("GO HOME"),
                    )
                  ],
                )
              : message == "Multiple Submission not allowed"
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.offAll(Home());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Badge(
                              toAnimate: true,
                              shape: BadgeShape.square,
                              badgeColor: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              badgeContent: Icon(
                                Icons.home,
                                size: 60,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Opps! Multiple Submission not allowed",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    )
                  : isLoading == true
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GradientProgressIndicator(
                              radius: 120,
                              duration: 1,
                              strokeWidth: 12,
                              gradientStops: const [0.2, 0.4, 0.6, 0.8, 1.0],
                              gradientColors: const [
                                Colors.green,
                                Colors.white,
                                Colors.grey,
                                Colors.white38,
                                Colors.green,
                              ],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Submitting.....',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  Text(
                                    'please wait!',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              InkWell(
                                onTap: (() {
                                  sendAndSaveResult();
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Badge(
                                    toAnimate: true,
                                    shape: BadgeShape.square,
                                    badgeColor: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    badgeContent: Icon(
                                      Icons.replay_outlined,
                                      size: 60,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Opps! Something went wrong from our End",
                                style: TextStyle(color: Colors.red),
                              ),
                            ])),
    );
  }
}
