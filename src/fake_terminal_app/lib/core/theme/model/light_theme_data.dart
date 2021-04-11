import 'package:flutter/material.dart';

final lightThemeData = _createLightTheme();

ThemeData _createLightTheme() {
  final baseTheme = ThemeData.light();
  final primaryColor = Color(0xFFdbdbdb);
  final darkPrimaryColor = Color(0xffbdbdbd);
  final accentColor = Color(0xff1e90ff);
  final accentTextColor = Color(0xff8e2a5c);
  final textColor = Colors.black;

  return baseTheme.copyWith(
    accentColor: accentColor,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    backgroundColor: primaryColor,
    cardColor: darkPrimaryColor,
    buttonTheme: baseTheme.buttonTheme.copyWith(highlightColor: accentColor),
    highlightColor: accentColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: textColor,
      selectionColor: accentColor,
      selectionHandleColor: accentColor,
    ),
    textTheme: baseTheme.textTheme
        .copyWith(
            bodyText1: baseTheme.textTheme.bodyText1?.copyWith(fontSize: 16),
            bodyText2: baseTheme.textTheme.bodyText2?.copyWith(fontSize: 16, fontWeight: FontWeight.bold))
        .apply(fontFamily: 'FiraCode', bodyColor: textColor),
    accentTextTheme: baseTheme.textTheme
        .copyWith(
            bodyText1: baseTheme.textTheme.bodyText1?.copyWith(fontSize: 16),
            bodyText2: baseTheme.textTheme.bodyText2?.copyWith(fontSize: 16, fontWeight: FontWeight.bold))
        .apply(fontFamily: 'FiraCode', bodyColor: accentTextColor),
  );
}
