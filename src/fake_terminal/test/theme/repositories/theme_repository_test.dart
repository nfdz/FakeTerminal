import 'package:fake_terminal/theme/models/stored_theme.dart';
import 'package:fake_terminal/theme/repositories/theme_repository.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'theme_repository_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('fetchThemeSettings', () {
    test('given the repository was empty then return null', () async {
      final preferences = MockSharedPreferences();
      when(preferences.getInt(ThemeRepositoryImpl.kThemeSettingsKey)).thenReturn(null);
      final repositoryInstance = ThemeRepositoryImpl(Future.value(preferences));
      final storedTheme = await repositoryInstance.fetchThemeSettings();
      expect(storedTheme, null);
    });

    test('given the repository contained light index then return light', () async {
      final preferences = MockSharedPreferences();
      when(preferences.getInt(ThemeRepositoryImpl.kThemeSettingsKey)).thenReturn(ThemeSettings.light.index);
      final repositoryInstance = ThemeRepositoryImpl(Future.value(preferences));
      final storedTheme = await repositoryInstance.fetchThemeSettings();
      expect(storedTheme!.settings, ThemeSettings.light);
    });

    test('given the repository contained dark index then return dark', () async {
      final preferences = MockSharedPreferences();
      when(preferences.getInt(ThemeRepositoryImpl.kThemeSettingsKey)).thenReturn(ThemeSettings.dark.index);
      final repositoryInstance = ThemeRepositoryImpl(Future.value(preferences));
      final storedTheme = await repositoryInstance.fetchThemeSettings();
      expect(storedTheme!.settings, ThemeSettings.dark);
    });
  });

  group('saveThemeSettings', () {
    test('given save was invoked with light settings then store is invoked with light index', () async {
      final preferences = MockSharedPreferences();
      when(preferences.setInt(ThemeRepositoryImpl.kThemeSettingsKey, any)).thenAnswer((_) async => true);
      final repositoryInstance = ThemeRepositoryImpl(Future.value(preferences));
      await repositoryInstance.saveThemeSettings(StoredTheme(ThemeSettings.light));
      verify(preferences.setInt(ThemeRepositoryImpl.kThemeSettingsKey, ThemeSettings.light.index)).called(1);
    });

    test('given save was invoked with dark settings then store is invoked with dark index', () async {
      final preferences = MockSharedPreferences();
      when(preferences.setInt(ThemeRepositoryImpl.kThemeSettingsKey, any)).thenAnswer((_) async => true);
      final repositoryInstance = ThemeRepositoryImpl(Future.value(preferences));
      await repositoryInstance.saveThemeSettings(StoredTheme(ThemeSettings.dark));
      verify(preferences.setInt(ThemeRepositoryImpl.kThemeSettingsKey, ThemeSettings.dark.index)).called(1);
    });
  });
}
