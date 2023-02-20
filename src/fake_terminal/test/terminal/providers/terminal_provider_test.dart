import 'package:fake_terminal/terminal/models/terminal_history.dart';
import 'package:fake_terminal/terminal/models/terminal_line.dart';
import 'package:fake_terminal/terminal/models/terminal_state.dart';
import 'package:fake_terminal/terminal/providers/terminal_provider.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_repository.dart';
import 'package:fake_terminal/terminal/repositories/history_repository/history_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'terminal_provider_test.mocks.dart';

@GenerateMocks([HistoryRepository, CommandsRepository])
void main() {
  group('StateNotifierProvider', () {
    test('creation given the repositories are present', () {
      final historyRepository = MockHistoryRepository();
      final commandRepository = MockCommandsRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => null);
      final container = ProviderContainer(
        overrides: [
          historyRepositoryProvider.overrideWith((ref) => historyRepository),
          commandsRepositoryProvider.overrideWith((ref) => commandRepository),
        ],
      );

      expect(container.read(terminalProvider), TerminalState(output: [], historyInput: []));
    });

    test('creation fails given the history repository is not present', () {
      final commandRepository = MockCommandsRepository();
      final container = ProviderContainer(
        overrides: [
          historyRepositoryProvider.overrideWith((ref) => throw Exception("This is an error")),
          commandsRepositoryProvider.overrideWith((ref) => commandRepository),
        ],
      );
      var creationFailed = false;
      try {
        container.read(terminalProvider);
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });

    test('creation fails given the command repository is not present', () {
      final historyRepository = MockHistoryRepository();
      final container = ProviderContainer(
        overrides: [
          historyRepositoryProvider.overrideWith((ref) => historyRepository),
          commandsRepositoryProvider.overrideWith((ref) => throw Exception("This is an error")),
        ],
      );
      var creationFailed = false;
      try {
        container.read(terminalProvider);
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });
  });
  group('initialization', () {
    test('state default', () async {
      final historyRepository = MockHistoryRepository();
      final commandRepository = MockCommandsRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => null);

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      expect(terminalProvider.debugState, TerminalNotifierImpl.welcomeState());
    });
    test('state restored from history', () async {
      final expectedHistoryInput = ["entry1", "entry2"];
      final expectedOutput = [
        TerminalLine(line: "line1", type: LineType.command),
        TerminalLine(line: "line2", type: LineType.result),
        TerminalLine(line: "line3", type: LineType.command),
      ];
      final expectedTimestampMillis = 1234;

      final historyRepository = MockHistoryRepository();
      final commandRepository = MockCommandsRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer(
        (_) async => TerminalHistory(
          output: expectedOutput,
          historyInput: expectedHistoryInput,
          timestampMillis: expectedTimestampMillis,
        ),
      );

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      expect(
        terminalProvider.debugState,
        TerminalState(
          historyInput: expectedHistoryInput,
          output: expectedOutput,
        ),
      );
    });
  });
  group('commands', () {
    test('canExitTerminal returns hasExitCommand', () async {
      final expectedValue = true;

      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => null);
      final commandRepository = MockCommandsRepository();
      when(commandRepository.hasExitCommand()).thenReturn(expectedValue);

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      expect(terminalProvider.canExitTerminal(), expectedValue);
      verify(commandRepository.hasExitCommand()).called(1);
    });
    test('exitTerminal invokes executeExitCommand', () async {
      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => null);
      final commandRepository = MockCommandsRepository();
      when(commandRepository.executeExitCommand()).thenReturn(null);

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      terminalProvider.exitTerminal();
      verify(commandRepository.executeExitCommand()).called(1);
    });
    test('navigateToRepository invokes executeOpenRepositoryCommand', () async {
      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => null);
      final commandRepository = MockCommandsRepository();
      when(commandRepository.executeOpenTerminalRepositoryCommand()).thenReturn(null);

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      terminalProvider.navigateToTerminalRepository();
      verify(commandRepository.executeOpenTerminalRepositoryCommand()).called(1);
    });
    test('executeCommand invokes executeCommandLine', () async {
      final commandLine = "myCommand myArg";
      final result = ExecuteCommandResult(output: [], history: []);

      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => null);
      final commandRepository = MockCommandsRepository();
      when(commandRepository.executeCommandLine(commandLine, any, any)).thenAnswer((_) async => result);

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      terminalProvider.executeCommand(commandLine);
      verify(commandRepository.executeCommandLine(commandLine, any, any)).called(1);
    });
    test('autocomplete invokes commands repository autocomplete', () async {
      final commandLine = "myCommand my";
      final expectedValue = "myCommand myArgComplete";

      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => null);
      final commandRepository = MockCommandsRepository();
      when(commandRepository.autocomplete(commandLine)).thenReturn(expectedValue);

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      expect(terminalProvider.autocomplete(commandLine), expectedValue);
      verify(commandRepository.autocomplete(commandLine)).called(1);
    });
  });
  group('history', () {
    test('navigateHistoryBack given history is empty then return null', () async {
      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => null);
      final commandRepository = MockCommandsRepository();

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      final commandLine = "";
      expect(terminalProvider.navigateHistoryBack(commandLine), null);
    });
    test('navigateHistoryForward given history is empty then return null', () async {
      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => null);
      final commandRepository = MockCommandsRepository();

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      final commandLine = "";
      expect(terminalProvider.navigateHistoryForward(commandLine), null);
    });
    test('navigateHistoryBack given history and empty command line then return history', () async {
      final historyEntry = "myHistoryCmd";
      final history = TerminalHistory(
        output: [],
        historyInput: [historyEntry],
        timestampMillis: 1234,
      );
      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => history);
      final commandRepository = MockCommandsRepository();

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      final commandLine = "";
      final expectedHistory = "!0 $historyEntry";
      expect(terminalProvider.navigateHistoryBack(commandLine), expectedHistory);
    });
    test('navigateHistoryBack given history and command line not related with history then return history', () async {
      final historyEntry = "myHistoryCmd";
      final history = TerminalHistory(
        output: [],
        historyInput: [historyEntry],
        timestampMillis: 1234,
      );
      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => history);
      final commandRepository = MockCommandsRepository();

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      final commandLine = "myCommand";
      final expectedHistory = "!0 $historyEntry";
      expect(terminalProvider.navigateHistoryBack(commandLine), expectedHistory);
    });
    test('navigateHistoryBack given history and command line with the history entry then return null', () async {
      final historyEntry = "myHistoryCmd";
      final history = TerminalHistory(
        output: [],
        historyInput: [historyEntry],
        timestampMillis: 1234,
      );
      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => history);
      final commandRepository = MockCommandsRepository();

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      final commandLine = "!0 $historyEntry";
      expect(terminalProvider.navigateHistoryBack(commandLine), null);
    });
    test('navigateHistoryForward given history and command line not related with the history then return null',
        () async {
      final historyEntry = "myHistoryCmd";
      final history = TerminalHistory(
        output: [],
        historyInput: [historyEntry],
        timestampMillis: 1234,
      );
      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => history);
      final commandRepository = MockCommandsRepository();

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      final commandLine = "";
      expect(terminalProvider.navigateHistoryForward(commandLine), null);
    });
    test('navigateHistoryForward given history and command line with the history entry then return empty string',
        () async {
      final historyEntry = "myHistoryCmd";
      final history = TerminalHistory(
        output: [],
        historyInput: [historyEntry],
        timestampMillis: 1234,
      );
      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => history);
      final commandRepository = MockCommandsRepository();

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      final commandLine = "!0 $historyEntry";
      expect(terminalProvider.navigateHistoryForward(commandLine), '');
    });
    test(
        'navigateHistoryBack given history with two entries and command line with second entry then return first entry',
        () async {
      final historyEntry1 = "myHistoryCmd1";
      final historyEntry2 = "myHistoryCmd2";
      final history = TerminalHistory(
        output: [],
        historyInput: [historyEntry1, historyEntry2],
        timestampMillis: 1234,
      );
      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => history);
      final commandRepository = MockCommandsRepository();

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      final commandLine = "!1 $historyEntry2";
      final expectedHistory = "!0 $historyEntry1";
      expect(terminalProvider.navigateHistoryBack(commandLine), expectedHistory);
    });
    test(
        'navigateHistoryForward given history with two entries and command line with first entry then return second entry',
        () async {
      final historyEntry1 = "myHistoryCmd1";
      final historyEntry2 = "myHistoryCmd2";
      final history = TerminalHistory(
        output: [],
        historyInput: [historyEntry1, historyEntry2],
        timestampMillis: 1234,
      );
      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => history);
      final commandRepository = MockCommandsRepository();

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      final commandLine = "!0 $historyEntry1";
      final expectedHistory = "!1 $historyEntry2";
      expect(terminalProvider.navigateHistoryForward(commandLine), expectedHistory);
    });
  });
}
