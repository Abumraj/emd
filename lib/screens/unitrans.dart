import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:uniapp/dbHelper/db.dart';

import '../entities.dart';

class UniTrans extends StatefulWidget {
  const UniTrans({Key? key}) : super(key: key);

  @override
  State<UniTrans> createState() => _UniTransState();
}

class _UniTransState extends State<UniTrans> {
  List<RegCourse> regCourse = [];
  bool isLoading = true;
  bool _isChecked = true;
  @override
  void initState() {
    getRegcourse();
    super.initState();
  }

  getRegcourse() async {
    final result = await ObjectBox.getAllRegCourse();
    setState(() {
      isLoading = false;
      regCourse = result;
    });
  }

  subscribeAndUnsubscribe(bool checked, String courseCode) async {
    checked
        ? await FirebaseMessaging.instance.subscribeToTopic(courseCode)
        : await FirebaseMessaging.instance.unsubscribeFromTopic(courseCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notifications"),
          centerTitle: true,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: regCourse.length,
                itemBuilder: (_, int indexes) {
                  RegCourse _videoList = regCourse[indexes];
                  return SwitchListTile(
                      title: Text(_videoList.coursecode!),
                      value: _isChecked,
                      onChanged: subscribeAndUnsubscribe(
                          _isChecked, _videoList.coursecode!));
                }));
  }
}
