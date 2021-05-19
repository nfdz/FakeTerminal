import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_repository.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/exit_executor.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/fake_data_to_commands.dart';
import 'package:fake_terminal/terminal/repositories/content_repository/content_repository.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/fake_data_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'commands_repository_test.mocks.dart';

@GenerateMocks([FakeDataRepository, ContentRepository, FakeDataToCommands, TerminalCommand, ExitExecutor])
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
      final fakeDataToCommands = MockFakeDataToCommands();
      when(fakeDataToCommands.loadCommands()).thenAnswer((_) async => []);

      final commandsRepository = CommandsRepositoryFakeData(fakeDataToCommands, MockExitExecutor());

      commandsRepository.initializationComplete.whenComplete(() {
        verify(fakeDataToCommands.loadCommands()).called(1);
      });
    });
  });

  group('autocomplete', () {
    test('given empty then return null', () {
      final fakeDataToCommands = MockFakeDataToCommands();
      when(fakeDataToCommands.loadCommands()).thenAnswer((_) async => []);

      final commandsRepository = CommandsRepositoryFakeData(fakeDataToCommands, MockExitExecutor());

      commandsRepository.initializationComplete.whenComplete(() {
        expect(commandsRepository.autocomplete(""), null);
      });
    });

    test('given invalid command name then return null', () {
      final commandName = "MyCommand";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.autocomplete(any)).thenReturn(null);
      final fakeDataToCommands = MockFakeDataToCommands();
      when(fakeDataToCommands.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository = CommandsRepositoryFakeData(fakeDataToCommands, MockExitExecutor());

      commandsRepository.initializationComplete.whenComplete(() {
        expect(commandsRepository.autocomplete("OtherComm"), null);
      });
    });

    test('given half command name then return command name', () {
      final commandName = "MyCommand";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.autocomplete(any)).thenReturn(null);
      final fakeDataToCommands = MockFakeDataToCommands();
      when(fakeDataToCommands.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository = CommandsRepositoryFakeData(fakeDataToCommands, MockExitExecutor());

      commandsRepository.initializationComplete.whenComplete(() {
        expect(commandsRepository.autocomplete("MyCom"), commandName);
      });
    });

    test('given the command name then return null', () {
      final commandName = "MyCommand";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.autocomplete(any)).thenReturn(null);
      final fakeDataToCommands = MockFakeDataToCommands();
      when(fakeDataToCommands.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository = CommandsRepositoryFakeData(fakeDataToCommands, MockExitExecutor());

      commandsRepository.initializationComplete.whenComplete(() {
        expect(commandsRepository.autocomplete(commandName), null);
      });
    });

    test(
        'given the command name with an argument then invoke the command autocomplete function and return the aggregated result',
        () {
      final expectedAutocompletedArgument = "myArgument";
      final commandName = "MyCommand";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.autocomplete(any)).thenReturn(expectedAutocompletedArgument);
      final fakeDataToCommands = MockFakeDataToCommands();
      when(fakeDataToCommands.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository = CommandsRepositoryFakeData(fakeDataToCommands, MockExitExecutor());

      commandsRepository.initializationComplete.whenComplete(() {
        final inputArgToAutocomplete = "myA";
        expect(commandsRepository.autocomplete("$commandName $inputArgToAutocomplete"),
            "$commandName $expectedAutocompletedArgument");
        verify(command.autocomplete(inputArgToAutocomplete)).called(1);
      });
    });
  });

  group('executeCommandLine', () {});
}
