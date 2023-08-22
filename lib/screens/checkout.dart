import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniapp/models/departCoursesModel.dart';
import 'package:uniapp/screens/refresh.dart';
import '../repository/apiRepository.dart';
import '../repository/apiRepositoryimplementation.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  ApiRepository _apiRepository = Get.put(ApiRepositoryImplementation());
  List<DepartCourse> _departCourse = [];
  String _message = '';
  @override
  void initState() {
    _loadDepartCourse();
    super.initState();
  }

  _loadDepartCourse() async {
    final result = await _apiRepository.getCart();
    if (result.isNotEmpty) {
      setState(() {
        _departCourse = result;
      });
      Get.snackbar("Discount", _message,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          icon: Icon(
            Icons.discount_sharp,
            color: Colors.purple,
          ),
          duration: Duration(seconds: 3));
    }
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        showCheckboxColumn: false,
        dataTextStyle:
            TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        columns: [
          // DataColumn(
          //   label: Text("COURSE NAME"),
          //   numeric: false,),
          DataColumn(
            label: Text("COURSE CODE"),
            numeric: false,
          ),
          // DataColumn(
          //   label: Text("UNIT"),
          //   numeric: true,
          // ),
          DataColumn(
            label: Text("PRICE"),
            numeric: true,
          ),
        ],
        rows: _departCourse.map((course) {
          // _totalPrice += course.coursePrice!;
          return DataRow(
              selected: _departCourse.contains(course),
              onSelectChanged: (b) {},
              cells: [
                DataCell(
                  Text(course.coursecode.toString()),
                ),
                DataCell(
                  Center(child: Text(course.courseUnit.toString())),
                ),
              ]);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          "SELECTED COURSES",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: _departCourse.isEmpty
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Center(
                    child: Text(
                      "SELECTED COURSE(S)",
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ),
                Expanded(
                  child: dataBody(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.purple,
                                elevation: 0.2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            child: Text(
                              "Enroll now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              _departCourse.forEach((element) async {
                                await FirebaseMessaging.instance
                                    .subscribeToTopic(element.coursecode!);
                              });
                              Get.offAll(Refresh());
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
