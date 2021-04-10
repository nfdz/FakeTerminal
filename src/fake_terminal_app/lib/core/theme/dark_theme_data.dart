import 'package:flutter/material.dart';

final darkThemeData = _createDarkTheme();

ThemeData _createDarkTheme() {
  final baseTheme = ThemeData.dark();
  final primaryColor = Color(0xFF242424);
  final lightPrimaryColor = Color(0xff424242);
  final accentColor = Color(0xff1e90ff);
  final accentTextColor = Color(0xff72d5a3);

  return baseTheme.copyWith(
    primaryColor: primaryColor,
    accentColor: accentColor,
    scaffoldBackgroundColor: primaryColor,
    backgroundColor: primaryColor,
    bottomAppBarColor: lightPrimaryColor,
    buttonTheme: baseTheme.buttonTheme.copyWith(highlightColor: accentColor),
    highlightColor: accentTextColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: accentColor,
      selectionHandleColor: accentColor,
    ),
    textTheme: baseTheme.textTheme.apply(fontFamily: 'FiraCode'),
    primaryTextTheme: baseTheme.primaryTextTheme.apply(fontFamily: 'FiraCode'),
    appBarTheme: baseTheme.appBarTheme.copyWith(elevation: 0, color: primaryColor),
  );
}
