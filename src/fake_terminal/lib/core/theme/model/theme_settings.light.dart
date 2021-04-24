part of 'theme_settings.dart';

ThemeData _createLightTheme() {
  final baseTheme = ThemeData.light();
  final primaryColor = Color(0xFFF8F8F8);
  final darkPrimaryColor = Color(0xffbdbdbd);
  final accentColor = Color(0xff1e90ff);
  final accentTextColor = Color(0xff8e2a5c);
  final textColor = Colors.black;
  final fontSizeBody = 6.8.sp;

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
    floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
      backgroundColor: accentColor,
      foregroundColor: Colors.white,
    ),
    textTheme: baseTheme.textTheme
        .copyWith(
            bodyText1: baseTheme.textTheme.bodyText1?.copyWith(fontSize: fontSizeBody),
            bodyText2: baseTheme.textTheme.bodyText2?.copyWith(fontSize: fontSizeBody, fontWeight: FontWeight.bold))
        .apply(fontFamily: 'FiraCode', bodyColor: textColor),
    accentTextTheme: baseTheme.textTheme
        .copyWith(
            bodyText1: baseTheme.textTheme.bodyText1?.copyWith(fontSize: fontSizeBody),
            bodyText2: baseTheme.textTheme.bodyText2?.copyWith(fontSize: fontSizeBody, fontWeight: FontWeight.bold))
        .apply(fontFamily: 'FiraCode', bodyColor: accentTextColor),
  );
}
