import 'package:fake_terminal_app/core/theme/local/theme_persistence.dart';
import 'package:fake_terminal_app/core/theme/local/theme_system.dart';
import 'package:fake_terminal_app/core/theme/model/theme_settings.dart';
import 'package:riverpod/riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeSettings>((ref) {
  return ThemeNotifier(ThemePersistencePreferences());
});

class ThemeNotifier extends StateNotifier<ThemeSettings> {
  final ThemePersistence _persistence;

  ThemeNotifier(this._persistence) : super(getDefaultThemeFromSystem()) {
    _initState();
  }

  void _initState() async {
    state = await _persistence.fetchThemeSettings();
  }

  ThemeSettings get theme {
    return state;
  }

  void toggleTheme() {
    state = state == ThemeSettings.dark ? ThemeSettings.light : ThemeSettings.dark;
  }
}
