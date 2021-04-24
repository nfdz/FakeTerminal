import 'package:fake_terminal/core/theme/local/theme_persistence.dart';
import 'package:fake_terminal/core/theme/model/theme_settings.dart';
import 'package:riverpod/riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeSettings>((ref) {
  return ThemeNotifier(ThemePersistencePreferences());
});

class ThemeNotifier extends StateNotifier<ThemeSettings> {
  static const _kDefaultTheme = ThemeSettings.dark;

  final ThemePersistence _persistence;

  ThemeNotifier(this._persistence) : super(_kDefaultTheme) {
    _initState();
  }

  void _initState() async {
    final savedTheme = await _persistence.fetchThemeSettings();
    if (savedTheme != null) {
      state = savedTheme;
    }
  }

  ThemeSettings get theme {
    return state;
  }

  void toggleTheme() {
    state = state == ThemeSettings.dark ? ThemeSettings.light : ThemeSettings.dark;
    _persistence.saveThemeSettings(state);
  }
}
