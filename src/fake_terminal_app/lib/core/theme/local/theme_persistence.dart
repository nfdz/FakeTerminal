import 'package:fake_terminal_app/core/theme/local/theme_system.dart';
import 'package:fake_terminal_app/core/theme/model/theme_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemePersistence {
  Future<ThemeSettings> fetchThemeSettings();
  Future<void> saveThemeSettings(ThemeSettings theme);
}

class ThemePersistencePreferences extends ThemePersistence {
  static const _kThemeSettingsKey = "theme";

  @override
  Future<ThemeSettings> fetchThemeSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getInt(_kThemeSettingsKey);
    return savedTheme != null ? ThemeSettings.values[savedTheme] : getDefaultThemeFromSystem();
  }

  @override
  Future<void> saveThemeSettings(ThemeSettings theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kThemeSettingsKey, theme.index);
  }
}
