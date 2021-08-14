part of 'theme_settings.dart';

ThemeData _createLightTheme(double fontSizeBody) {
  final baseTheme = ThemeData.light();
  final primaryColor = Color(0xFFFFFFFF);
  final darkPrimaryColor = Color(0xFFF4F4F4);
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
    floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
      backgroundColor: accentColor,
      foregroundColor: Colors.white,
    ),
    textTheme: baseTheme.textTheme
        .copyWith(
          bodyText1: baseTheme.textTheme.bodyText1?.copyWith(fontSize: fontSizeBody, fontFamily: 'FiraCode'),
          bodyText2: baseTheme.textTheme.bodyText2
              ?.copyWith(fontSize: fontSizeBody, fontWeight: FontWeight.bold, fontFamily: 'FiraCode'),
          subtitle1: baseTheme.textTheme.subtitle1?.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
          subtitle2: baseTheme.textTheme.subtitle1?.copyWith(fontSize: 17, fontWeight: FontWeight.normal),
        )
        .apply(bodyColor: textColor),
    accentTextTheme: baseTheme.textTheme
        .copyWith(
          bodyText1: baseTheme.textTheme.bodyText1?.copyWith(fontSize: fontSizeBody, fontFamily: 'FiraCode'),
          bodyText2: baseTheme.textTheme.bodyText2
              ?.copyWith(fontSize: fontSizeBody, fontWeight: FontWeight.bold, fontFamily: 'FiraCode'),
        )
        .apply(bodyColor: accentTextColor),
  );
}
