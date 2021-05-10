import 'package:fake_terminal/theme/repositories/theme_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'theme_repository_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('fetchThemeSettings', () {
    test('settings given the repository was empty', () async {
      final preferences = MockSharedPreferences();
      when(preferences.getInt(ThemeRepositoryPreferences.kThemeSettingsKey)).thenReturn(null);
      final repositoryInstance = ThemeRepositoryPreferences(Future.value(preferences));
      await repositoryInstance.fetchThemeSettings();
      expect(repositoryInstance, isA<ThemeRepositoryPreferences>());
    });
  });
}
