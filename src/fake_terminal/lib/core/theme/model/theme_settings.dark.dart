part of 'theme_settings.dart';

ThemeData _createDarkTheme() {
  final baseTheme = ThemeData.dark();
  final primaryColor = Color(0xFF242424);
  final lightPrimaryColor = Color(0xff424242);
  final accentColor = Color(0xff1e90ff);
  final accentTextColor = Color(0xff72d5a3);
  final textColor = Colors.white;
  final fontSizeBody = 6.8.sp;

  return baseTheme.copyWith(
    accentColor: accentColor,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    backgroundColor: primaryColor,
    cardColor: lightPrimaryColor,
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