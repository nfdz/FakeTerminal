import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'theme_settings.dark.dart';
part 'theme_settings.light.dart';

enum ThemeSettings { dark, light }

extension ThemeSettingsX on ThemeSettings {
  ThemeData data() {
    switch (this) {
      case ThemeSettings.dark:
        return _createDarkTheme();
      case ThemeSettings.light:
        return _createLightTheme();
    }
  }
}
