import 'package:fake_terminal_app/core/theme/model/dark_theme_data.dart';
import 'package:flutter/material.dart';

enum ThemeSettings { dark, light }

extension ThemeExtension on ThemeSettings {
  ThemeData get data {
    switch (this) {
      case ThemeSettings.dark:
        // TODO: Implement light theme
        return darkThemeData;
      case ThemeSettings.light:
        return darkThemeData;
    }
  }
}
