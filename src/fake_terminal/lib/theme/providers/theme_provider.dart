import 'package:fake_terminal/theme/repositories/theme_repository.dart';
import 'package:fake_terminal/theme/modles/theme_settings.dart';
import 'package:riverpod/riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeSettings>((ref) {
  final repository = ref.read(themeRepositoryProvider);
  return ThemeNotifier(repository);
});

class ThemeNotifier extends StateNotifier<ThemeSettings> {
  static const _kDefaultTheme = ThemeSettings.dark;

  final ThemeRepository _repository;

  ThemeNotifier(this._repository) : super(_kDefaultTheme) {
    _initState();
  }

  void _initState() async {
    final savedTheme = await _repository.fetchThemeSettings();
    if (savedTheme != null) {
      state = savedTheme;
    }
  }

  ThemeSettings get theme {
    return state;
  }

  void toggleTheme() {
    state = state == ThemeSettings.dark ? ThemeSettings.light : ThemeSettings.dark;
    _repository.saveThemeSettings(state);
  }
}
