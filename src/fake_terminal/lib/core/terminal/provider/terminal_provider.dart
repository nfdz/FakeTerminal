import 'package:fake_terminal/core/commands/commands_loader.dart';
import 'package:fake_terminal/core/commands/model/terminal_command.dart';
import 'package:fake_terminal/core/commands/special_commands/clear_command.dart';
import 'package:fake_terminal/core/commands/special_commands/history_command.dart';
import 'package:fake_terminal/core/terminal/local/terminal_persistence.dart';
import 'package:fake_terminal/core/terminal/local/terminal_system.dart';
import 'package:fake_terminal/core/terminal/model/terminal_history.dart';
import 'package:fake_terminal/core/terminal/model/terminal_line.dart';
import 'package:fake_terminal/core/terminal/model/terminal_state.dart';
import 'package:fake_terminal/core/texts/terminal_texts.dart';
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

final terminalProvider = StateNotifierProvider<TerminalNotifier, TerminalState>((ref) {
  return TerminalNotifier(TerminalPersistencePreferences(), CommandsLoaderWithFakeData());
});

final Logger _kLogger = Logger("TerminalProvider");

class TerminalNotifier extends StateNotifier<TerminalState> {
  final TerminalPersistence _persistence;
  final CommandsLoader _commandsLoader;
  List<TerminalCommand> _commands = [];

  TerminalNotifier(this._persistence, this._commandsLoader) : super(TerminalState(output: [], historyInput: [])) {
    _initState();
  }

  void _initState() async {
    _commands = await _commandsLoader.load(
      getHistory: () => state.historyInput,
      onExitTerminal: exitTerminal,
    );
    final history = await _persistence.fetchTerminalHistory();
    if (history != null) {
      _restoreFromHistory(history);
    } else {
      state = getDefaultTerminalFromSystem();
    }
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

  void executeCommand(String commandLine) async {
    _kLogger.fine("Execute command invoked with commandLine=$commandLine");
    final newState = state;

    // history pointer replacement
    if (commandLine.startsWith('!')) {
      newState.output.add(_commandOutputLine(commandLine));
      final historyIndexString = commandLine.replaceFirst('!', '');
      final historyIndex = int.tryParse(historyIndexString);
      if (historyIndex != null && historyIndex >= 0 && historyIndex < state.historyInput.length) {
        commandLine = state.historyInput.elementAt(historyIndex);
        _kLogger.fine("Replaced command from history commandLine=$commandLine");
      } else {
        newState.output.add(_invalidHistoryIndexOutputLine(commandLine));
        state = newState;
        _persistence.saveTerminalHistory(newState.snapshot());
        return;
      }
    }

    newState.historyInput.add(commandLine);
    final commandWithArguments = commandLine.split(" ").map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (commandWithArguments.isEmpty) {
      newState.output.add(_emptyOutputLine());
    } else {
      newState.output.add(_commandOutputLine(commandLine));
      final commandName = commandWithArguments[0];
      final matches = _commands.where((command) => command.name == commandName);
      if (matches.isNotEmpty) {
        final command = matches.first;
        commandWithArguments.removeAt(0);
        final arguments = commandWithArguments;
        try {
          final outputList = await command.execute(arguments);
          final outputString = outputList
              .fold<String>("", (previousValue, element) => previousValue + "\n" + element)
              .replaceFirst("\n", "");
          newState.output.add(TerminalLine(line: outputString, type: LineType.result));
        } on ExecuteClearCommand {
          newState.output.clear();
        } on ExecuteClearHistoryCommand {
          newState.historyInput.clear();
        }
      } else {
        newState.output.add(_commandNotFoundOutputLine(commandName));
      }
    }
    state = newState;
    _persistence.saveTerminalHistory(newState.snapshot());
  }

  TerminalLine _emptyOutputLine() => TerminalLine(
        line: "",
        type: LineType.result,
        prefix: TerminalTexts.terminalInputPrefix,
      );
  TerminalLine _commandOutputLine(String commandLine) => TerminalLine(
        line: commandLine,
        type: LineType.command,
        prefix: TerminalTexts.terminalInputPrefix,
      );
  TerminalLine _commandNotFoundOutputLine(String commandName) => TerminalLine(
        line: _commandNotFound(commandName),
        type: LineType.result,
      );
  String _commandNotFound(String commandName) => "bash: $commandName: command not found";

  TerminalLine _invalidHistoryIndexOutputLine(String index) => TerminalLine(
        line: _invalidHistoryIndex(index),
        type: LineType.result,
      );
  String _invalidHistoryIndex(String index) => "bash: event not found: $index";

  bool canExitTerminal() {
    // TODO
    return true;
  }

  void exitTerminal() {
    _kLogger.fine("Exit Terminal invoked");
    // TODO
    if (canExitTerminal()) {}
  }

  String? autocomplete(String commandLine) {
    _kLogger.fine("Autocomplete invoked with commandLine=$commandLine");
    final commandWithArguments = commandLine.split(" ").map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (commandWithArguments.isNotEmpty) {
      final commandName = commandWithArguments[0];
      final matches = _commands.where((command) => command.name.startsWith(commandName));
      if (matches.isNotEmpty) {
        final command = matches.first;
        commandWithArguments.removeAt(0);
        if (commandWithArguments.isNotEmpty) {
          final lastArgument = commandWithArguments.last;
          final lastArgumentComplete = command.autocomplete(lastArgument);
          if (lastArgumentComplete == null || lastArgumentComplete == lastArgument) {
            return null;
          }
          commandWithArguments.removeLast();
          commandWithArguments.add(lastArgumentComplete);
        } else if (commandName == command.name) {
          return null;
        }
        final result =
            commandWithArguments.fold<String>(command.name, (previousValue, element) => previousValue + " " + element);
        _kLogger.fine("Autocomplete result=$result");
        return result;
      }
    }
    return null;
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
