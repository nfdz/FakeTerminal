import 'package:fake_terminal/theme/repositories/theme_repository.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:riverpod/riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeSettings>((ref) {
  final repository = ref.read(themeRepositoryProvider);
  return ThemeNotifierImpl(repository);
});

abstract class ThemeNotifier extends StateNotifier<ThemeSettings> {
  ThemeNotifier(ThemeSettings state) : super(state);

  void toggleTheme();
}

class ThemeNotifierImpl extends ThemeNotifier {
  static const _kDefaultTheme = ThemeSettings.dark;

  final ThemeRepository _repository;

  ThemeNotifierImpl(this._repository) : super(_kDefaultTheme) {
    _initState();
  }

  void _initState() async {
    final savedTheme = await _repository.fetchThemeSettings();
    if (savedTheme != null) {
      state = savedTheme;
    }
  }

  @override
  void toggleTheme() {
    state = state == ThemeSettings.dark ? ThemeSettings.light : ThemeSettings.dark;
    _repository.saveThemeSettings(state);
  }
}
