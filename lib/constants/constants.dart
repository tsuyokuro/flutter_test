import 'package:flutter/material.dart';

class LightMode {
  static Color textColor = Colors.black26;
  static Color inputTextLabel = const Color.fromARGB(255, 102, 52, 52);
  static MaterialColor primarySwatch = Colors.indigo;

  static ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.blue),
    foregroundColor: MaterialStateProperty.all(Colors.white),
  );

  static ThemeData appThemeData = ThemeData(
    primarySwatch: LightMode.primarySwatch,
  );

  static TextStyle basicTextStyle = const TextStyle();
}
