import 'dart:ffi';

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
          historyRepositoryProvider.overrideWithProvider(Provider((ref) => historyRepository)),
          commandsRepositoryProvider.overrideWithProvider(Provider((ref) => commandRepository)),
        ],
      );
      final providerInstance = container.readProviderElement(terminalProvider).state.createdValue;
      expect(providerInstance, isA<TerminalNotifierImpl>());
    });

    test('creation fails given the history repository is not present', () {
      final commandRepository = MockCommandsRepository();
      final container = ProviderContainer(
        overrides: [
          historyRepositoryProvider.overrideWithProvider(Provider((ref) => throw Exception("This is an error"))),
          commandsRepositoryProvider.overrideWithProvider(Provider((ref) => commandRepository)),
        ],
      );
      var creationFailed = false;
      try {
        container.readProviderElement(terminalProvider).state.createdValue;
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
          historyRepositoryProvider.overrideWithProvider(Provider((ref) => historyRepository)),
          commandsRepositoryProvider.overrideWithProvider(Provider((ref) => throw Exception("This is an error"))),
        ],
      );
      var creationFailed = false;
      try {
        container.readProviderElement(terminalProvider).state.createdValue;
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
      when(commandRepository.executeExitCommand()).thenReturn(Void);

      final terminalProvider = TerminalNotifierImpl(historyRepository, commandRepository);
      await terminalProvider.initializationComplete;

      terminalProvider.exitTerminal();
      verify(commandRepository.executeExitCommand()).called(1);
    });
    test('executeCommand invokes executeCommandLine', () async {
      final commandLine = "myCommand myArg";

      final historyRepository = MockHistoryRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => null);
      final commandRepository = MockCommandsRepository();
      when(commandRepository.executeCommandLine(commandLine, any, any)).thenAnswer((_) async => null);

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
  group('history', () {});
}
