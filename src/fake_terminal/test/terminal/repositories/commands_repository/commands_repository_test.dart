import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_repository.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/fake_data_to_commands.dart';
import 'package:fake_terminal/terminal/repositories/content_repository/content_repository.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/fake_data_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'commands_repository_test.mocks.dart';

@GenerateMocks([FakeDataRepository, ContentRepository, FakeDataToCommands])
void main() {
  final _fakeDataMock = FakeData(fakeCommands: [
    FakeCommand(
      name: "TestFakeCommandWithOutput",
      description: "test description",
      arguments: [],
      outputUrl: null,
      output: "test output",
    ),
    FakeCommand(
      name: "TestFakeCommandWithOutputUrl",
      description: "test description",
      arguments: [],
      outputUrl: "https://myoutputurl",
      output: null,
    ),
  ], fakeFiles: [
    FakeFile(
      name: "MyFakeFileWithContent",
      content: "test content",
    ),
    FakeFile(
      name: "MyFakeFileWithContentUrl",
      contentUrl: "https://mycontenturl",
    ),
  ]);
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

  group('initialization', () {
    test('fetch fake data', () {
      final fakeDataRepository = MockFakeDataRepository();
      when(fakeDataRepository.load()).thenAnswer((_) async => _fakeDataMock);
      final contentRepository = MockContentRepository();
      final fakeDataToCommands = MockFakeDataToCommands();
      when(fakeDataToCommands.createCommands(
        fakeData: anyNamed('fakeData'),
        contentRepository: anyNamed('contentRepository'),
        hasExitCommand: anyNamed('hasExitCommand'),
        executeExitCommand: anyNamed('executeExitCommand'),
      )).thenReturn([]);

      final commandsRepository = CommandsRepositoryFakeData(fakeDataRepository, contentRepository, fakeDataToCommands);

      commandsRepository.initializationComplete.whenComplete(
        () {
          verify(fakeDataRepository.load()).called(1);
          verify(fakeDataToCommands.createCommands(
            fakeData: _fakeDataMock,
            contentRepository: contentRepository,
            hasExitCommand: anyNamed('hasExitCommand'),
            executeExitCommand: anyNamed('executeExitCommand'),
          )).called(1);
        },
      );
    });
  });
}
