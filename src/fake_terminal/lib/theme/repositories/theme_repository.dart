import 'package:fake_terminal/theme/models/stored_theme.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';

final themeRepositoryProvider =
    Provider<ThemeRepository>((ref) => ThemeRepositoryImpl(SharedPreferences.getInstance()));

abstract class ThemeRepository {
  Future<StoredTheme?> fetchThemeSettings();
  Future<void> saveThemeSettings(StoredTheme theme);
}

class ThemeRepositoryImpl extends ThemeRepository {
  static const kThemeSettingsKey = "theme";

  final Future<SharedPreferences> _sharedPreferences;
  ThemeRepositoryImpl(this._sharedPreferences);

  @override
  Future<StoredTheme?> fetchThemeSettings() async {
    SharedPreferences prefs = await _sharedPreferences;
    final savedTheme = prefs.getInt(kThemeSettingsKey);
    return savedTheme != null ? StoredTheme(ThemeSettings.values[savedTheme]) : null;
  }

  @override
  Future<void> saveThemeSettings(StoredTheme theme) async {
    SharedPreferences prefs = await _sharedPreferences;
    await prefs.setInt(kThemeSettingsKey, theme.settings.index);
  }
}
