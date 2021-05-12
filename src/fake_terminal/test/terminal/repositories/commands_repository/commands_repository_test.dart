import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_repository.dart';
import 'package:fake_terminal/terminal/repositories/content_repository/content_repository.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/fake_data_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'commands_repository_test.mocks.dart';

@GenerateMocks([FakeDataRepository, ContentRepository])
void main() {
  group('Provider', () {
    test('creation given FakeDataRepository and ContentRepository are present', () {
      final fakeDataRepository = MockFakeDataRepository();
      final contentRepository = MockContentRepository();
      when(fakeDataRepository.load()).thenAnswer((_) async => FakeData(fakeCommands: [], fakeFiles: []));
      final container = ProviderContainer(
        overrides: [
          fakeDataRepositoryProvider.overrideWithProvider(Provider((ref) => fakeDataRepository)),
          contentRepositoryProvider.overrideWithProvider(Provider((ref) => contentRepository)),
        ],
      );
      final providerInstance = container.readProviderElement(commandsRepositoryProvider).state.createdValue;
      expect(providerInstance, isA<CommandsRepositoryFakeData>());
    });

    test('creation fails given FakeDataRepository is not present', () {
      final contentRepository = MockContentRepository();
      final container = ProviderContainer(
        overrides: [
          fakeDataRepositoryProvider.overrideWithProvider(Provider((ref) => throw Exception("This is an error"))),
          contentRepositoryProvider.overrideWithProvider(Provider((ref) => contentRepository)),
        ],
      );

      var creationFailed = false;
      try {
        container.readProviderElement(commandsRepositoryProvider).state.createdValue;
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });

    test('creation fails given ContentRepository is not present', () {
      final fakeDataRepository = MockFakeDataRepository();
      final container = ProviderContainer(
        overrides: [
          fakeDataRepositoryProvider.overrideWithProvider(Provider((ref) => fakeDataRepository)),
          contentRepositoryProvider.overrideWithProvider(Provider((ref) => throw Exception("This is an error"))),
        ],
      );

      var creationFailed = false;
      try {
        container.readProviderElement(commandsRepositoryProvider).state.createdValue;
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });
  });
}
