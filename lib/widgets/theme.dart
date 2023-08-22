import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
      primaryColor: Colors.purple,
      primarySwatch: Colors.purple,
      brightness: Brightness.light,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ));
  static final dark = ThemeData(
      primaryColor: Colors.black,
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ));
}
