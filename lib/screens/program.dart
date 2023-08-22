import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniapp/Services/uapi.dart';
import 'package:uniapp/dbHelper/constant.dart';
import 'package:uniapp/models/school.dart';
import 'package:uniapp/screens/login.dart';
// import 'package:uniapp/services/uapi.dart';
import 'package:uniapp/widgets/data.dart';

class Programs extends StatefulWidget {
  @override
  _ProgramsState createState() => _ProgramsState();
}

class _ProgramsState extends State<Programs> {
  List<SliderModel> mySLides = [];

  List<School>? program = <School>[];

  PageController _controller = PageController(viewportFraction: 0.75);
  var currentValue = 0.0;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentValue = _controller.page!;
      });
    });
    isLoading = true;
    _getFaculty();
    mySLides = getSlides();
  }

  _getFaculty() async {
    await Uapi.getSchool().then((value) {
      setState(() {
        print(value);
        program = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: Colors.purple,
        //   title: Text(
        //     "Program Selection",
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 18.0,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: InkWell(
        //           child: Icon(Icons.refresh),
        //           onTap: () {
        //             _getFaculty();
        //           }),
        //     )
        //   ],
        // ),
        // // backgroundColor: Colors.purple,
        body: Container(
      // height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: _controller,
                    // onPageChanged: (value) {

                    // },
                    itemBuilder: (context, position) {
                      if (position == currentValue.toInt()) {
                        return Transform.scale(
                          // scale: 1.1,
                          scaleX: 1,
                          scaleY: 1,
                          child: Card(
                            elevation: 16,
                            child: GestureDetector(
                              onTap: (() {
                                print(program![position].schoolCode);
                                Constants
                                    .saveFirebaseTopicByProgramInSharedPreference(
                                        program![position].schoolName!);

                                Constants.saveUserSchoolSharedPreference(
                                    program![position].schoolCode!);

                                Get.off(() => Login(
                                    portal: program![position].schoolName!));
                              }),
                              child: ProgramTitled(
                                  imagePath: mySLides[0].imageAssetPath,
                                  title: program![position].schoolName!),
                            ),
                          ),
                        );
                      } else if (position == currentValue.toInt() + 1) {
                        return Transform.scale(
                          scale: 0.8,
                          child: Card(
                            elevation: 8,
                            child: ProgramTitled(
                                imagePath: mySLides[0].imageAssetPath,
                                title: program![position].schoolName!),
                          ),
                        );
                      } else {
                        return Transform.scale(
                          scale: 0.8,
                          child: Card(
                            elevation: 8,
                            child: ProgramTitled(
                                imagePath: mySLides[0].imageAssetPath,
                                title: program![position].schoolName!),
                          ),
                        );
                      }
                    },
                    // pageSnapping: true,
                    padEnds: true,
                    itemCount: program!.length,
                  ),
                ),
              ],
            ),
    )
        //  Container(
        //   color: Colors.white,
        //   child: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.max,
        //       children: children2,
        //     ),
        //   ),
        // ),
        );
  }
}

class ProgramTitled extends StatelessWidget {
  var imagePath;
  var title;

  ProgramTitled({
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      // height: MediaQuery.of(context).size.height / 3,
      // width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
              radius: 98,
              backgroundColor: Colors.white,
              child: Image.asset(
                imagePath,
                width: 110,
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
