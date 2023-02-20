part of 'theme_settings.dart';

ThemeData _createDarkTheme(double fontSizeBody) {
  final baseTheme = ThemeData.dark();
  final primaryColor = Color(0xFF242424);
  final lightPrimaryColor = Color(0xff424242);
  final accentColor = Color(0xff1e90ff);
  final accentTextColor = Color(0xff72d5a3);
  final textColor = Colors.white;

  return baseTheme.copyWith(
    colorScheme: baseTheme.colorScheme.copyWith(
      background: primaryColor,
      primary: primaryColor,
      secondary: accentColor,
      onSecondary: accentTextColor,
    ),
    scaffoldBackgroundColor: primaryColor,
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
          bodyLarge: baseTheme.textTheme.bodyLarge?.copyWith(fontSize: fontSizeBody, fontFamily: 'FiraCode'),
          bodyMedium: baseTheme.textTheme.bodyMedium
              ?.copyWith(fontSize: fontSizeBody, fontWeight: FontWeight.bold, fontFamily: 'FiraCode'),
          titleMedium: baseTheme.textTheme.titleMedium?.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
          titleSmall: baseTheme.textTheme.titleMedium?.copyWith(fontSize: 17, fontWeight: FontWeight.normal),
          displayLarge: baseTheme.textTheme.bodyLarge?.copyWith(fontSize: fontSizeBody, fontFamily: 'FiraCode'),
          displayMedium: baseTheme.textTheme.bodyMedium
              ?.copyWith(fontSize: fontSizeBody, fontWeight: FontWeight.bold, fontFamily: 'FiraCode'),
        )
        .apply(bodyColor: textColor),
  );
}
