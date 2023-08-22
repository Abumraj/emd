import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:uniapp/models/questionModel.dart';
import 'package:uniapp/widgets/countdown.dart';
import 'package:uniapp/widgets/submit.dart';

class TestQuizPage extends StatefulWidget {
  final List<Question> questions;
  final chapterName;
  final quesNum;
  final quesTime;
  final chapterId;
  const TestQuizPage(
      {Key? key,
      required this.questions,
      this.chapterName,
      this.quesNum,
      this.quesTime,
      this.chapterId})
      : super(key: key);

  @override
  State<TestQuizPage> createState() => _TestQuizPageState();
}

class _TestQuizPageState extends State<TestQuizPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);
  late AnimationController _controller;
  int levelClock = 0;
  int _currentIndex = 0;
  int maxQuest = 0;
  int quesTime = 0;
  bool isLoading = true;
  final List<Question> shuffleQuestion = [];
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController _germanTextEditor = TextEditingController();
  Timer? _timer;
  int _counter = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    createQuestion();
    disableScreenRecord();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: 2), () {
      // Redirect user to another page after 2 seconds in the paused state
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => Submit(
                questions: shuffleQuestion,
                answers: _answers,
                chapterName: widget.chapterName,
                chapterId: widget.chapterId,
              )));
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _startTimer();
    } else if (state == AppLifecycleState.resumed) {
      _timer!.cancel();
    }
  }

  createQuestion() {
    maxQuest = widget.quesNum;
    levelClock = widget.quesTime * 60;
    if (widget.questions.length > 0) {
      for (var i = 0; shuffleQuestion.length < maxQuest; i++) {
        widget.questions.shuffle();
        shuffleQuestion.add(widget.questions[i]);
      }
    }
    determineTime();
  }

  determineTime() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds: levelClock -
                1) // gameData.levelClock is a user entered number elsewhere in the applciation
        );
    // if (levelClock > 0) {
    _controller.forward().whenComplete(() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => Submit(
                questions: shuffleQuestion,
                answers: _answers,
                chapterName: widget.chapterName,
                chapterId: widget.chapterId,
              )));
    });
    isLoading = false;
  }

  disableScreenRecord() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    Question question = shuffleQuestion[_currentIndex];
    final List<dynamic> options = [
      question.option2,
      question.option3,
      question.option4
    ];
    options.removeWhere((element) => element.toString() == "null");
    if (options.length > 0 && options.length != 4) {
      options.add(question.option1);
      options.shuffle();
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: <Widget>[
          Countdown(
            animation: StepTween(
              begin: levelClock - 1, // THIS IS A USER ENTERED NUMBER
              end: 0,
            ).animate(_controller),
          ),
          new TextButton(
            child: Text("submit"),
            onPressed: _nextSubmit,
            style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )),
          ),
        ],
        elevation: 0.5,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.purple,
            ))
          : WillPopScope(
              onWillPop: () async {
                final shouldPop = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'You are not allowed to leave this screen during Test.',
                        style: TextStyle(color: Colors.purple, fontSize: 17),
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text('Continue'),
                        ),
                      ],
                    );
                  },
                );
                return shouldPop!;
              },
              child: Stack(
                children: <Widget>[
                  ClipRect(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      height: 250,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          child: Text(
                            widget.chapterName,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Text(
                                "${_currentIndex + 1}" + "/" + "$maxQuest",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.purple),
                              ),
                              maxRadius: 18,
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                                child: shuffleQuestion[_currentIndex]
                                            .question
                                            .toString() !=
                                        "null"
                                    ? Text(
                                        HtmlUnescape().convert(
                                            shuffleQuestion[_currentIndex]
                                                .question!),
                                        softWrap: true,
                                        style: _questionStyle,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: shuffleQuestion[_currentIndex]
                                            .imageUrl!)),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Card(
                          child: options.length > 1
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ...options.map((option) =>
                                        RadioListTile<dynamic>(
                                          enableFeedback: true,
                                          selected: true,
                                          toggleable: true,
                                          activeColor: Colors.purple,
                                          title: Text(HtmlUnescape()
                                              .convert("$option")),
                                          groupValue: _answers[_currentIndex],
                                          value: option,
                                          onChanged: (value) {
                                            setState(() {
                                              _answers[_currentIndex] = option;
                                            });
                                          },
                                        )),
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      TextFormField(
                                        controller: _germanTextEditor,
                                        // initialValue:
                                        //     _answers[_currentIndex] == null
                                        //         ? ''
                                        //         : _answers[_currentIndex],
                                        onChanged: (s) {
                                          setState(() {
                                            _answers[_currentIndex] = s;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            labelText: "Type Your Answer Here",
                                            labelStyle: TextStyle(
                                                color: Colors.purple,
                                                fontSize: 12)),
                                      )
                                    ],
                                  ),
                                ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    elevation: 0.2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    textStyle: TextStyle(color: Colors.white),
                                  ),
                                  child: Text("Previous",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: _previous,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    elevation: 0.2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    textStyle: TextStyle(color: Colors.white),
                                  ),
                                  child: Text("Next",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: _next,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  void _next() {
    if (_currentIndex < (maxQuest - 1)) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _previous() {
    if (_currentIndex > 0 &&
        (_currentIndex < (maxQuest - 1) || _currentIndex == (maxQuest - 1))) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _nextSubmit() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => Submit(
              questions: shuffleQuestion,
              answers: _answers,
              chapterName: widget.chapterName,
              chapterId: widget.chapterId,
            )));
  }
}
