import 'dart:async';

import 'package:fake_terminal/theme/models/stored_theme.dart';
import 'package:fake_terminal/theme/repositories/theme_repository.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:riverpod/riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeSettings>((ref) {
  final repository = ref.read(themeRepositoryProvider);
  return ThemeNotifierImpl(repository);
});

abstract class ThemeNotifier extends StateNotifier<ThemeSettings> {
  ThemeNotifier(ThemeSettings state) : super(state);

  Future get initializationComplete;
  void toggleTheme();
}

class ThemeNotifierImpl extends ThemeNotifier {
  static const _kDefaultTheme = ThemeSettings.dark;

  @override
  Future get initializationComplete => _initCompleter.future;

  final _initCompleter = Completer();
  final ThemeRepository _repository;

  ThemeNotifierImpl(this._repository, {ThemeSettings initialState = _kDefaultTheme}) : super(initialState) {
    _initState().whenComplete(() => _initCompleter.complete());
  }

  Future<void> _initState() async {
    final savedTheme = await _repository.fetchThemeSettings();
    if (savedTheme != null) {
      state = savedTheme.settings;
    }
  }

  @override
  void toggleTheme() {
    state = state == ThemeSettings.dark ? ThemeSettings.light : ThemeSettings.dark;
    _repository.saveThemeSettings(StoredTheme(state));
  }
}
