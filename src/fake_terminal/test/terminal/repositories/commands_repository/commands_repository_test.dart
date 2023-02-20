import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';
import 'package:fake_terminal/terminal/models/terminal_line.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/code_repository_executor.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands/commands.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_loader.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_repository.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/exit_executor.dart';
import 'package:fake_terminal/terminal/repositories/content_repository/content_repository.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/fake_data_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'commands_repository_test.mocks.dart';

@GenerateMocks(
    [FakeDataRepository, ContentRepository, CommandsLoader, TerminalCommand, ExitExecutor, CodeRepositoryExecutor])
void main() {
  group('Provider', () {
    test('creation given FakeDataRepository and ContentRepository are present', () {
      final fakeDataRepository = MockFakeDataRepository();
      final contentRepository = MockContentRepository();
      when(fakeDataRepository.load()).thenAnswer((_) async => FakeData(fakeCommands: [], fakeFiles: []));
      final container = ProviderContainer(
        overrides: [
          fakeDataRepositoryProvider.overrideWith((ref) => fakeDataRepository),
          contentRepositoryProvider.overrideWith((ref) => contentRepository),
        ],
      );
      final providerInstance = container.read(commandsRepositoryProvider);
      expect(providerInstance, isA<CommandsRepositoryFakeData>());
    });

    test('creation fails given FakeDataRepository is not present', () {
      final contentRepository = MockContentRepository();
      final container = ProviderContainer(
        overrides: [
          fakeDataRepositoryProvider.overrideWith((ref) => throw Exception("This is an error")),
          contentRepositoryProvider.overrideWith((ref) => contentRepository),
        ],
      );

      var creationFailed = false;
      try {
        container.read(commandsRepositoryProvider);
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
          fakeDataRepositoryProvider.overrideWith((ref) => fakeDataRepository),
          contentRepositoryProvider.overrideWith((ref) => throw Exception("This is an error")),
        ],
      );

      var creationFailed = false;
      try {
        container.read(commandsRepositoryProvider);
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });
  });

  group('initialization', () {
    test('fetch fake data', () async {
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => []);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      verify(commandsLoader.loadCommands()).called(1);
    });
  });

  group('autocomplete', () {
    test('given empty then return null', () async {
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => []);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      expect(commandsRepository.autocomplete(""), null);
    });

    test('given invalid command name then return null', () async {
      final commandName = "MyCommand";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.autocomplete(any)).thenReturn(null);
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      expect(commandsRepository.autocomplete("OtherComm"), null);
    });

    test('given half command name then return command name', () async {
      final commandName = "MyCommand";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.autocomplete(any)).thenReturn(null);
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      expect(commandsRepository.autocomplete("MyCom"), commandName);
    });

    test('given the command name then return null', () async {
      final commandName = "MyCommand";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.autocomplete(any)).thenReturn(null);
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      expect(commandsRepository.autocomplete(commandName), null);
    });

    test(
        'given the command name with half of a valid argument then invoke the command autocomplete function and return the aggregated result',
        () async {
      final expectedAutocompletedArgument = "myArgument";
      final commandName = "MyCommand";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.autocomplete(any)).thenReturn(expectedAutocompletedArgument);
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      final inputArgToAutocomplete = "myA";
      expect(commandsRepository.autocomplete("$commandName $inputArgToAutocomplete"),
          "$commandName $expectedAutocompletedArgument");
      verify(command.autocomplete(inputArgToAutocomplete)).called(1);
    });

    test(
        'given the command name with half of an invalid argument then invoke the command autocomplete function and return null',
        () async {
      final commandName = "MyCommand";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.autocomplete(any)).thenReturn(null);
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      final inputArgToAutocomplete = "myA";
      expect(commandsRepository.autocomplete("$commandName $inputArgToAutocomplete"), null);
      verify(command.autocomplete(inputArgToAutocomplete)).called(1);
    });
  });

  group('executeCommandLine', () {
    group('history pointer', () {
      test('given empty history then do not execute any command and save the expected lines and history', () async {
        final commandsLoader = MockCommandsLoader();
        when(commandsLoader.loadCommands()).thenAnswer((_) async => []);

        final commandsRepository =
            CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
        await commandsRepository.initializationComplete;

        final List<TerminalLine> output = [];
        final List<String> history = [];

        final historyPointer = "!1";
        final result = await commandsRepository.executeCommandLine(historyPointer, output, history);

        expect(result.output.length, 2);
        expect(result.output[0].type, LineType.command);
        expect(result.output[0].line, historyPointer);
        expect(result.output[1].type, LineType.result);
        expect(result.history, []);
      });

      test(
          'given history with 1 entry and invalid pointer then do not execute any command and save the expected lines and history',
          () async {
        final commandsLoader = MockCommandsLoader();
        when(commandsLoader.loadCommands()).thenAnswer((_) async => []);

        final commandsRepository =
            CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
        await commandsRepository.initializationComplete;

        final List<TerminalLine> output = [];
        final commandHistory = "MyCommand-1";
        final List<String> history = [commandHistory];

        final historyPointer = "!4";
        final result = await commandsRepository.executeCommandLine(historyPointer, output, history);

        expect(result.output.length, 2);
        expect(result.output[0].type, LineType.command);
        expect(result.output[0].line, historyPointer);
        expect(result.output[1].type, LineType.result);
        expect(result.history, [commandHistory]);
      });

      test(
          'given history with 1 entry and valid pointer then do execute the command from history and save the expected lines and history',
          () async {
        final commandName = "MyCommand";
        final commandOutput = "MyOutput";
        final command = MockTerminalCommand();
        when(command.name).thenReturn(commandName);
        when(command.execute(arguments: anyNamed("arguments"), history: anyNamed("history")))
            .thenAnswer((_) async => [commandOutput]);
        final commandsLoader = MockCommandsLoader();
        when(commandsLoader.loadCommands()).thenAnswer((_) async => [command]);

        final commandsRepository =
            CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
        await commandsRepository.initializationComplete;

        final List<TerminalLine> output = [];
        final List<String> history = [commandName];

        final historyPointer = "!0";
        final result = await commandsRepository.executeCommandLine(historyPointer, output, history);

        expect(result.output.length, 3);
        expect(result.output[0].type, LineType.command);
        expect(result.output[0].line, historyPointer);
        expect(result.output[1].type, LineType.command);
        expect(result.output[1].line, commandName);
        expect(result.output[2].type, LineType.result);
        expect(result.output[2].line, commandOutput);

        final expectedHistory = [commandName, commandName];
        verify(command.execute(arguments: anyNamed("arguments"), history: expectedHistory)).called(1);
      });
    });

    test('given empty line then do not execute any command and save the expected lines', () async {
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => []);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      final List<TerminalLine> output = [];

      final result = await commandsRepository.executeCommandLine("", output, []);

      expect(result.output.length, 1);
      expect(result.output[0].type, LineType.result);
      expect(result.output[0].line, "");
    });

    test('given invalid command then do not execute any command and save the expected lines', () async {
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => []);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      final List<TerminalLine> output = [];

      final invalidCommand = "MyCommand";
      final result = await commandsRepository.executeCommandLine(invalidCommand, output, []);

      expect(result.output.length, 2);
      expect(result.output[0].type, LineType.command);
      expect(result.output[0].line, invalidCommand);
      expect(result.output[1].type, LineType.result);
    });

    test(
        'given valid command with no arguments then do execute the command with no arguments and save the expected lines and history',
        () async {
      final commandName = "MyCommand";
      final commandOutput = "MyOutput";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.execute(arguments: anyNamed("arguments"), history: anyNamed("history")))
          .thenAnswer((_) async => [commandOutput]);
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      final List<TerminalLine> output = [];

      final result = await commandsRepository.executeCommandLine(commandName, output, []);

      expect(result.output.length, 2);
      expect(result.output[0].type, LineType.command);
      expect(result.output[0].line, commandName);
      expect(result.output[1].type, LineType.result);
      expect(result.output[1].line, commandOutput);

      final expectedArguments = <String>[];
      final expectedHistory = [commandName];
      verify(command.execute(arguments: expectedArguments, history: expectedHistory)).called(1);
    });

    test(
        'given valid command with 2 arguments then do execute the command with 2 arguments and save the expected lines and history',
        () async {
      final commandName = "MyCommand";
      final commandOutput = "MyOutput";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.execute(arguments: anyNamed("arguments"), history: anyNamed("history")))
          .thenAnswer((_) async => [commandOutput]);
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      final List<TerminalLine> output = [];

      final myArg1 = "myArg1";
      final myArg2 = "myArg2";
      final commandLine = "$commandName $myArg1 $myArg2";
      final result = await commandsRepository.executeCommandLine(commandLine, output, []);

      expect(result.output.length, 2);
      expect(result.output[0].type, LineType.command);
      expect(result.output[0].line, commandLine);
      expect(result.output[1].type, LineType.result);
      expect(result.output[1].line, commandOutput);

      final expectedArguments = [myArg1, myArg2];
      final expectedHistory = [commandLine];
      verify(command.execute(arguments: expectedArguments, history: expectedHistory)).called(1);
    });

    test('given valid command that throws ExecuteClearCommand then clear the output', () async {
      final commandName = "MyClearOutputCommand";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.execute(arguments: anyNamed("arguments"), history: anyNamed("history")))
          .thenThrow(ExecuteClearCommand());
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      final List<TerminalLine> output = [TerminalLine(line: "AnyOutput", type: LineType.result)];

      final result = await commandsRepository.executeCommandLine(commandName, output, []);

      expect(result.output.length, 0);

      final expectedHistory = [commandName];
      verify(command.execute(arguments: [], history: expectedHistory)).called(1);
    });

    test('given valid command that throws ExecuteClearHistoryCommand then clear the history', () async {
      final commandName = "MyClearHistoryCommand";
      final command = MockTerminalCommand();
      when(command.name).thenReturn(commandName);
      when(command.execute(arguments: anyNamed("arguments"), history: anyNamed("history")))
          .thenThrow(ExecuteClearHistoryCommand());
      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => [command]);

      final commandsRepository =
          CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      final previousHistoryLine = "MyPreviousCommand";
      final List<String> history = [previousHistoryLine];

      final result = await commandsRepository.executeCommandLine(commandName, [], history);
      expect(result.history.length, 0);

      verify(command.execute(arguments: anyNamed("arguments"), history: anyNamed("history"))).called(1);
    });
  });

  group('exit', () {
    test('hasExitCommand invoke ExitExecutor.hasExitCommand and returns the value', () async {
      final exitExecutor = MockExitExecutor();
      final expectedValue = true;
      when(exitExecutor.hasExitCommand()).thenReturn(expectedValue);

      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => []);

      final commandsRepository = CommandsRepositoryFakeData(commandsLoader, exitExecutor, MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      expect(commandsRepository.hasExitCommand(), expectedValue);
      verify(exitExecutor.hasExitCommand()).called(1);
    });

    test('executeExitCommand invoke ExitExecutor.executeExitCommand', () async {
      final exitExecutor = MockExitExecutor();
      when(exitExecutor.executeExitCommand()).thenReturn(null);

      final commandsLoader = MockCommandsLoader();
      when(commandsLoader.loadCommands()).thenAnswer((_) async => []);

      final commandsRepository = CommandsRepositoryFakeData(commandsLoader, exitExecutor, MockCodeRepositoryExecutor());
      await commandsRepository.initializationComplete;

      commandsRepository.executeExitCommand();
      verify(exitExecutor.executeExitCommand()).called(1);
    });
  });

  test('executeOpenRepositoryCommand invoke CodeRepositoryExecutor.executeOpenRepositoryCommand', () async {
    final codeRepositoryExecutor = MockCodeRepositoryExecutor();
    when(codeRepositoryExecutor.executeOpenTerminalRepositoryCommand()).thenReturn(null);

    final commandsLoader = MockCommandsLoader();
    when(commandsLoader.loadCommands()).thenAnswer((_) async => []);

    final commandsRepository = CommandsRepositoryFakeData(commandsLoader, MockExitExecutor(), codeRepositoryExecutor);
    await commandsRepository.initializationComplete;

    commandsRepository.executeOpenTerminalRepositoryCommand();
    verify(codeRepositoryExecutor.executeOpenTerminalRepositoryCommand()).called(1);
  });
}
