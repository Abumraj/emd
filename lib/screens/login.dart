import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniapp/dbHelper/constant.dart';
import 'package:uniapp/models/studentType.dart';
import 'package:uniapp/screens/ForgotPassword.dart';
import 'package:uniapp/screens/home.dart';
import 'package:uniapp/screens/signUp.dart';
import 'package:uniapp/widgets/header_widget.dart';
import 'package:uniapp/widgets/hexColor.dart';
import 'package:uniapp/widgets/theme_helper.dart';
import '../Services/uapi.dart';

class Login extends StatefulWidget {
  final String? portal;

  const Login({required this.portal});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  late String token;
  bool loading = false;
  bool isUserLoggedIn = false;
  String? school;
  void initState() {
    _getSchool();

    super.initState();
  }

  _getSchool() async {
    await Constants.getUserSchoolSharedPreference().then((value) {
      school = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    double _headerHeight = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.person), //let's create a common header widget
            ),
            SafeArea(
                child: !loading
                    ? Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        margin: EdgeInsets.fromLTRB(
                            20, 10, 20, 10), // This will be the login form
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.portal!,
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Welcome, signin into your account',
                              style: TextStyle(color: Colors.purple),
                            ),
                            SizedBox(height: 30.0),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      child: TextFormField(
                                        controller: _emailTextController,
                                        decoration: ThemeHelper()
                                            .textInputDecoration(
                                                "Matric Number*",
                                                "Enter your matric number"),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (val) {
                                          // ignore: prefer_is_not_empty
                                          if (!(val!.isEmpty) &&
                                              !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                  .hasMatch(val)) {
                                            return "Enter a valid email address";
                                          } else if (val.isEmpty) {
                                            return "Matric Number is required";
                                          }
                                          return null;
                                        },
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 30.0),
                                    Container(
                                      child: TextFormField(
                                        controller: _passwordTextController,
                                        obscureText: true,
                                        decoration: ThemeHelper()
                                            .textInputDecoration("Password*",
                                                "Enter your password"),

                                        // ignore: missing_return
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Password is required";
                                          } else if (value.length < 6) {
                                            return "the password has to be at least 6 characters long";
                                          } else
                                            return null;
                                        },
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 15.0),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(10, 0, 10, 20),
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(ForgotPassword());
                                        },
                                        child: Text(
                                          "Forgot your password?",
                                          style: TextStyle(
                                            color: Colors.purple,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: ThemeHelper()
                                          .buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              40, 10, 40, 10),
                                          child: Text(
                                            'Sign In'.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () {
                                          userLogin();
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ))
                    : Visibility(
                        visible: loading == true,
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.purple),
                            ),
                          ),
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  Future userLogin() async {
    FormState? formState = _formKey.currentState;
    // Getting value from Controller
    String email = _emailTextController.text;
    String password = _passwordTextController.text;
    // Store all data with Param Name.
    var data = {
      'email': email,
      'password': password,
      // 'fcmToken': widget.fcmToken
    };

    Constants.saveUserMailSharedPreference(email);

    if (formState!.validate()) {
      // Showing CircularProgressIndicator.
      setState(() {
        loading = true;
      });

      // SERVER LOGIN API URL
      var url = "$school/remedial/login";
      Dio dio = Dio();
      var response = await dio.post(
        url,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }),
      );
      var result = response.data;

      var message = result["access_token"];

      if (message != null) {
        Constants.saveUserTokenSharedPreference(message);
        setState(() {
          token = message;
          Constants.saveUserLoggedInSharedPreference(true);
        });
        Get.offAll(() => Home());
      } else {
        setState(() {
          loading = false;
        });
        // Showing Alert Dialog with Response JSON Message.
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: Border(),
              title: new Text(
                response.data['info'],
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20.00,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: new Text("OK"),
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
  }
}
