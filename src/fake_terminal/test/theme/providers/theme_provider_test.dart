import 'package:fake_terminal/theme/providers/theme_provider.dart';
import 'package:fake_terminal/theme/repositories/theme_repository.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'theme_provider_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  group('StateNotifierProvider', () {
    test('creation given the repository is present', () {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      final container = ProviderContainer(
        overrides: [themeRepositoryProvider.overrideWithProvider(Provider((ref) => repository))],
      );
      final providerInstance = container.readProviderElement(themeProvider).state.createdValue;
      expect(providerInstance, isA<ThemeNotifierImpl>());
    });

    test('creation fails given the repository is not present', () {
      final container = ProviderContainer(
        overrides: [
          themeRepositoryProvider.overrideWithProvider(Provider((ref) => throw Exception("This is an error")))
        ],
      );

      var creationFailed = false;
      try {
        container.readProviderElement(themeProvider).state.createdValue;
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });
  });

  group('initialization', () {
    test('state default', () {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      final themeProvider = ThemeNotifierImpl(repository);
      expect(themeProvider.debugState, ThemeSettings.dark);
    });

    test('state given the repository was empty', () {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      final themeProvider = ThemeNotifierImpl(repository);
      themeProvider.initializationComplete.whenComplete(
        () => expect(themeProvider.debugState, ThemeSettings.dark),
      );
    });

    test('state given the repository had light', () {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => StoredTheme(ThemeSettings.light));
      final themeProvider = ThemeNotifierImpl(repository);
      themeProvider.initializationComplete.whenComplete(
        () => expect(themeProvider.debugState, ThemeSettings.light),
      );
    });
  });

  group('toggleTheme', () {
    test('given the state was light then the new state is dark', () {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      when(repository.saveThemeSettings(any)).thenAnswer((_) async => null);
      final themeProvider = ThemeNotifierImpl(repository, initialState: ThemeSettings.light);

      themeProvider.toggleTheme();

      expect(themeProvider.debugState, ThemeSettings.dark);
    });

    test('given the state was light then save dark in the repository', () {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      when(repository.saveThemeSettings(any)).thenAnswer((_) async => null);
      final themeProvider = ThemeNotifierImpl(repository, initialState: ThemeSettings.light);

      themeProvider.toggleTheme();

      verify(repository.saveThemeSettings(StoredTheme(ThemeSettings.dark))).called(1);
    });

    test('given the state was dark then the new state is light', () {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      when(repository.saveThemeSettings(any)).thenAnswer((_) async => null);
      final themeProvider = ThemeNotifierImpl(repository, initialState: ThemeSettings.dark);

      themeProvider.toggleTheme();

      expect(themeProvider.debugState, ThemeSettings.light);
    });

    test('given the state was dark then save light in the repository', () {
      final repository = MockThemeRepository();
      when(repository.fetchThemeSettings()).thenAnswer((_) async => null);
      when(repository.saveThemeSettings(any)).thenAnswer((_) async => null);
      final themeProvider = ThemeNotifierImpl(repository, initialState: ThemeSettings.dark);

      themeProvider.toggleTheme();

      verify(repository.saveThemeSettings(StoredTheme(ThemeSettings.light))).called(1);
    });
  });
}
