import 'package:fake_terminal_app/core/commands/commands_loader.dart';
import 'package:fake_terminal_app/core/commands/model/terminal_command.dart';
import 'package:fake_terminal_app/core/commands/special_commands/clear_command.dart';
import 'package:fake_terminal_app/core/terminal/local/terminal_persistence.dart';
import 'package:fake_terminal_app/core/terminal/local/terminal_system.dart';
import 'package:fake_terminal_app/core/terminal/model/terminal_history.dart';
import 'package:fake_terminal_app/core/terminal/model/terminal_line.dart';
import 'package:fake_terminal_app/core/terminal/model/terminal_state.dart';
import 'package:fake_terminal_app/core/texts/terminal_texts.dart';
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

  TerminalNotifier(this._persistence, this._commandsLoader) : super(getDefaultTerminalFromSystem()) {
    _initState();
  }

  void _initState() async {
    _commands = await _commandsLoader.load(
      getHistory: () => state.historyInput,
      onExitTerminal: _onExitTerminal,
    );
    final history = await _persistence.fetchTerminalHistory();
    if (history != null) {
      _restoreFromHistory(history);
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
    var newState = state;
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
          newState = TerminalState(output: [], historyInput: []);
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

  void _onExitTerminal() {
    _kLogger.fine("Exit Terminal invoked");
  }
}
