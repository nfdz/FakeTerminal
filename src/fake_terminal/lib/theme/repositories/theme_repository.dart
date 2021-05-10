import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';

final themeRepositoryProvider =
    Provider<ThemeRepository>((ref) => ThemeRepositoryPreferences(SharedPreferences.getInstance()));

abstract class ThemeRepository {
  Future<ThemeSettings?> fetchThemeSettings();
  Future<void> saveThemeSettings(ThemeSettings theme);
}

class ThemeRepositoryPreferences extends ThemeRepository {
  static const kThemeSettingsKey = "theme";
  final Future<SharedPreferences> _sharedPreferences;

  ThemeRepositoryPreferences(this._sharedPreferences);

  @override
  Future<ThemeSettings?> fetchThemeSettings() async {
    SharedPreferences prefs = await _sharedPreferences;
    final savedTheme = prefs.getInt(kThemeSettingsKey);
    return savedTheme != null ? ThemeSettings.values[savedTheme] : null;
  }

  @override
  Future<void> saveThemeSettings(ThemeSettings theme) async {
    SharedPreferences prefs = await _sharedPreferences;
    await prefs.setInt(kThemeSettingsKey, theme.index);
  }
}
