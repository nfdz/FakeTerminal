import 'package:fake_terminal/theme/models/stored_theme.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:fake_terminal/theme/providers/theme_provider.dart';
import 'package:fake_terminal/theme/repositories/theme_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod/src/framework.dart';
import 'package:test/test.dart';

import 'theme_provider_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  group('StateNotifierProvider', () {
    test('creation given the repository is present', () {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      final container = ProviderContainer(
        overrides: [themeRepositoryProvider.overrideWith((ref) => repository)],
      );

      expect(container.read(themeProvider), ThemeSettings.dark);
    });

    test('creation fails given the repository is not present', () {
      final container = ProviderContainer(
        overrides: [themeRepositoryProvider.overrideWith((ref) => throw Exception("This is an error"))],
      );

      var creationFailed = false;
      try {
        container.read(themeProvider);
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });
  });

  group('initialization', () {
    test('state default', () async {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);

      final themeProvider = ThemeNotifierImpl(repository);
      await themeProvider.initializationComplete;

      expect(themeProvider.debugState, ThemeSettings.dark);
    });

    test('state given the repository was empty', () async {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);

      final themeProvider = ThemeNotifierImpl(repository);
      await themeProvider.initializationComplete;

      expect(themeProvider.debugState, ThemeSettings.dark);
    });

    test('state given the repository had light', () async {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => StoredTheme(ThemeSettings.light));

      final themeProvider = ThemeNotifierImpl(repository);
      await themeProvider.initializationComplete;

      expect(themeProvider.debugState, ThemeSettings.light);
    });
  });

  group('toggleTheme', () {
    test('given the state was light then the new state is dark', () async {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      when(repository.saveThemeSettings(any)).thenAnswer((_) async => null);

      final themeProvider = ThemeNotifierImpl(repository, initialState: ThemeSettings.light);
      await themeProvider.initializationComplete;

      themeProvider.toggleTheme();

      expect(themeProvider.debugState, ThemeSettings.dark);
    });

    test('given the state was light then save dark in the repository', () async {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      when(repository.saveThemeSettings(any)).thenAnswer((_) async => null);

      final themeProvider = ThemeNotifierImpl(repository, initialState: ThemeSettings.light);
      await themeProvider.initializationComplete;

      themeProvider.toggleTheme();

      verify(repository.saveThemeSettings(StoredTheme(ThemeSettings.dark))).called(1);
    });

    test('given the state was dark then the new state is light', () async {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      when(repository.saveThemeSettings(any)).thenAnswer((_) async => null);

      final themeProvider = ThemeNotifierImpl(repository, initialState: ThemeSettings.dark);
      await themeProvider.initializationComplete;

      themeProvider.toggleTheme();

      expect(themeProvider.debugState, ThemeSettings.light);
    });

    test('given the state was dark then save light in the repository', () async {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      when(repository.saveThemeSettings(any)).thenAnswer((_) async => null);

      final themeProvider = ThemeNotifierImpl(repository, initialState: ThemeSettings.dark);
      await themeProvider.initializationComplete;

      themeProvider.toggleTheme();

      verify(repository.saveThemeSettings(StoredTheme(ThemeSettings.light))).called(1);
    });
  });
}
