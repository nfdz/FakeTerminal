import 'package:fake_terminal/core/theme/model/dark_theme_data.dart';
import 'package:fake_terminal/core/theme/model/light_theme_data.dart';
import 'package:flutter/material.dart';

enum ThemeSettings { dark, light }

extension ThemeExtension on ThemeSettings {
  ThemeData get data {
    switch (this) {
      case ThemeSettings.dark:
        return darkThemeData;
      case ThemeSettings.light:
        return lightThemeData;
    }
  }
}
