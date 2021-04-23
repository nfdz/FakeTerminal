import 'package:fake_terminal/core/theme/model/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:logging/logging.dart';

final Logger _kLogger = Logger("ThemeSystem");

ThemeSettings getDefaultThemeFromSystem() {
  final brightness = SchedulerBinding.instance?.window.platformBrightness;
  _kLogger.log(Level.FINE, "(getDefaultThemeFromSystem) System.Brightness: $brightness");
  final isSystemThemeLight = brightness == Brightness.light;
  return isSystemThemeLight ? ThemeSettings.light : ThemeSettings.dark;
}
