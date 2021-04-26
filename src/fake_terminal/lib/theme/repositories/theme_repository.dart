import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';

final themeRepositoryProvider = Provider<ThemeRepository>((ref) => _ThemeRepositoryPreferences());

abstract class ThemeRepository {
  Future<ThemeSettings?> fetchThemeSettings();
  Future<void> saveThemeSettings(ThemeSettings theme);
}

class _ThemeRepositoryPreferences extends ThemeRepository {
  static const _kThemeSettingsKey = "theme";

  @override
  Future<ThemeSettings?> fetchThemeSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getInt(_kThemeSettingsKey);
    return savedTheme != null ? ThemeSettings.values[savedTheme] : null;
  }

  @override
  Future<void> saveThemeSettings(ThemeSettings theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kThemeSettingsKey, theme.index);
  }
}
