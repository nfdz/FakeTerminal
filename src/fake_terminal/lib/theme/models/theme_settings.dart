import 'package:fake_terminal/sizer/sizer_extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'theme_settings.dark.dart';
part 'theme_settings.light.dart';

enum ThemeSettings { dark, light }

extension ThemeSettingsX on ThemeSettings {
  ThemeData data() {
    final fontSizeBody = 6.4.sp.withMaxValue(18);
    switch (this) {
      case ThemeSettings.dark:
        return _createDarkTheme(fontSizeBody);
      case ThemeSettings.light:
        return _createLightTheme(fontSizeBody);
    }
  }
}
