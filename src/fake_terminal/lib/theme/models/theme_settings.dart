import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'theme_settings.dark.dart';
part 'theme_settings.light.dart';

enum ThemeSettings { dark, light }

extension ThemeSettingsX on ThemeSettings {
  ThemeData data() {
    final fontSizeBody = 6.4.sp;
    switch (this) {
      case ThemeSettings.dark:
        return _createDarkTheme(fontSizeBody);
      case ThemeSettings.light:
        return _createLightTheme(fontSizeBody);
    }
  }
}
