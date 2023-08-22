import 'package:flutter/material.dart';
import 'package:uniapp/models/questionModel.dart';
import 'package:uniapp/widgets/testpage.dart';

class TestOptionDialog extends StatefulWidget {
  final List<Question> questions;
  final chapterName;
  final quesNum;
  final quesTime;
  final chapterId;
  const TestOptionDialog(
      {Key? key,
      required this.questions,
      this.chapterName,
      this.quesNum,
      this.quesTime,
      this.chapterId})
      : super(key: key);

  @override
  State<TestOptionDialog> createState() => _TestOptionDialogState();
}

class _TestOptionDialogState extends State<TestOptionDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.chapterName.toString().toUpperCase()),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "You have " +
                    widget.quesTime.toString() +
                    " mins to answer " +
                    widget.quesNum.toString() +
                    " Questions",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                    elevation: 0.2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "Start".toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  widget.questions.length >= widget.quesNum
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TestQuizPage(
                                  questions: widget.questions,
                                  chapterName: widget.chapterName,
                                  chapterId: widget.chapterId,
                                  quesNum: widget.quesNum,
                                  quesTime: widget.quesTime)))
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              title: new Text(
                                "There is currently no question associated with this chapter or the course is probably not CBT based. ",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 15.00,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: new Text("Ok"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
