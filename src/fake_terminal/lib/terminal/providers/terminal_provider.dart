import 'package:fake_terminal/terminal/models/terminal_history.dart';
import 'package:fake_terminal/terminal/models/terminal_line.dart';
import 'package:fake_terminal/terminal/models/terminal_state.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_repository.dart';
import 'package:fake_terminal/terminal/repositories/history_repository/persistence_repository.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

final terminalProvider = StateNotifierProvider<TerminalNotifier, TerminalState>((ref) {
  final historyRepository = ref.read(historyRepositoryProvider);
  final commandsRepository = ref.read(commandsRepositoryProvider);
  return TerminalNotifier(historyRepository, commandsRepository);
});

final Logger _kLogger = Logger("TerminalNotifier");

class TerminalNotifier extends StateNotifier<TerminalState> {
  final HistoryRepository _historyRepository;
  final CommandsRepository _commandsRepository;

  TerminalNotifier(this._historyRepository, this._commandsRepository)
      : super(TerminalState(output: [], historyInput: [])) {
    _initState();
  }

//#region Initialization
  Future<void> _initState() async {
    final history = await _historyRepository.fetchTerminalHistory();
    if (history != null) {
      _restoreFromHistory(history);
    } else {
      state = _welcomeState();
    }
  }

  TerminalState _welcomeState() {
    // TODO UA
    return TerminalState(
      historyInput: [],
      output: [
        TerminalLine(line: TerminalTexts.welcomeText, type: LineType.result),
      ],
    );
  }

  void _restoreFromHistory(TerminalHistory history) {
    _kLogger.fine("Restored history");
    final newState = TerminalState(output: history.output, historyInput: history.historyInput);
    if (history.output.isNotEmpty) {
      final timestampText = TerminalTexts.lastLoginMessage(history.timestampMillis);
      newState.output.add(TerminalLine(
        type: LineType.timestamp,
        line: "\n$timestampText\n",
      ));
    }
    state = newState;
  }
//#endregion

//#region Public event handlers
  bool canExitTerminal() => _commandsRepository.hasExitCommand();

  void exitTerminal() => _commandsRepository.executeExitCommand();

  void executeCommand(String commandLine) async {
    final newState = state;
    await _commandsRepository.executeCommandLine(commandLine, newState.output, newState.historyInput);
    state = newState;
    _historyRepository.saveTerminalHistory(newState.snapshot());
  }

  String? autocomplete(String commandLine) {
    return _commandsRepository.autocomplete(commandLine);
  }

  String? navigateHistoryBack(String commandLine) {
    _kLogger.fine("NavigateHistoryBack invoked with commandLine=$commandLine");
    final historyMap = _getHistoryMap();
    if (historyMap.isEmpty) {
      return null;
    }
    final currentEntryMatches = historyMap.entries.where((e) => commandLine == e.value);
    if (currentEntryMatches.isNotEmpty) {
      final nextBackIndex = currentEntryMatches.first.key + 1;
      return historyMap[nextBackIndex];
    } else {
      return historyMap.values.first;
    }
  }

  String? navigateHistoryForward(String commandLine) {
    _kLogger.fine("NavigateHistoryForward invoked with commandLine=$commandLine");
    final historyMap = _getHistoryMap();
    if (historyMap.isEmpty) {
      return null;
    }
    final currentEntryMatches = historyMap.entries.where((e) => commandLine == e.value);
    if (currentEntryMatches.isNotEmpty) {
      final nextForwardIndex = currentEntryMatches.first.key - 1;
      return historyMap[nextForwardIndex];
    } else {
      return null;
    }
  }
//#endregion

  Map<int, String> _getHistoryMap() {
    final Map<int, String> historyMap = {};
    int index = 0;
    for (final historyEntry in state.historyInput.reversed) {
      historyMap[index] = historyEntry;
      index++;
    }
    return historyMap;
  }
}
