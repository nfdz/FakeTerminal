import 'package:fake_terminal/terminal/models/commands/commands.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';
import 'package:fake_terminal/terminal/models/terminal_history.dart';
import 'package:fake_terminal/terminal/models/terminal_line.dart';
import 'package:fake_terminal/terminal/models/terminal_state.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_repository.dart';
import 'package:fake_terminal/terminal/repositories/persistence_repository/persistence_repository.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

final terminalProvider = StateNotifierProvider<TerminalNotifier, TerminalState>((ref) {
  final persistenceRepository = ref.read(persistenceRepositoryProvider);
  final commandsRepository = ref.read(commandsRepositoryProvider);
  return TerminalNotifier(persistenceRepository, commandsRepository);
});

final Logger _kLogger = Logger("TerminalNotifier");

class TerminalNotifier extends StateNotifier<TerminalState> {
  final PersistenceRepository _persistenceRepository;
  final CommandsRepository _commandsRepository;

  List<TerminalCommand> _commands = [];

  TerminalNotifier(this._persistenceRepository, this._commandsRepository)
      : super(TerminalState(output: [], historyInput: [])) {
    _init();
  }

//#region Initialization
  void _init() async {
    _initCommands();
    _initState();
  }

  Future<void> _initCommands() async {
    _commands = await _commandsRepository.load(
      getHistory: () => state.historyInput,
      onExitTerminal: canExitTerminal() ? exitTerminal : null,
    );
  }

  Future<void> _initState() async {
    final history = await _persistenceRepository.fetchTerminalHistory();
    if (history != null) {
      _restoreFromHistory(history);
    } else {
      state = _initWelcomeState();
    }
  }

  TerminalState _initWelcomeState() {
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
  bool canExitTerminal() {
    // TODO
    return true;
  }

  void exitTerminal() {
    _kLogger.fine("Exit Terminal invoked");
    // TODO
    if (canExitTerminal()) {}
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
        _persistenceRepository.saveTerminalHistory(newState.snapshot());
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
    _persistenceRepository.saveTerminalHistory(newState.snapshot());
  }
//#endregion

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
