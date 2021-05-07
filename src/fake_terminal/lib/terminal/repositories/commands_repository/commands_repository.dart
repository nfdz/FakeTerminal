import 'package:fake_terminal/plugins/javascript_dom/javascript_dom.dart';
import 'package:fake_terminal/terminal/models/commands/commands.dart';
import 'package:fake_terminal/terminal/models/commands/js_command.dart';
import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';
import 'package:fake_terminal/terminal/models/terminal_line.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/fake_data_repository.dart';
import 'package:fake_terminal/terminal/repositories/content_repository/content_repository.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

final commandsRepositoryProvider = Provider<CommandsRepository>((ref) {
  final fakeDataRepository = ref.read(fakeDataRepositoryProvider);
  final contentRepository = ref.read(contentRepositoryProvider);
  return _CommandsRepositoryFakeData(fakeDataRepository, contentRepository);
});

final Logger _kLogger = Logger("CommandsRepository");

abstract class CommandsRepository {
  bool hasExitCommand();
  void executeExitCommand();
  String? autocomplete(String commandLine);
  Future<void> executeCommandLine(String commandLine, List<TerminalLine> output, List<String> history);
}

class _CommandsRepositoryFakeData extends CommandsRepository {
  final FakeDataRepository _fakeDataRepository;
  final ContentRepository _contentRepository;

  List<TerminalCommand> _commands = [];

  _CommandsRepositoryFakeData(this._fakeDataRepository, this._contentRepository) {
    _init();
  }

  void _init() async {
    _commands = await _loadCommands();
  }

  Future<List<TerminalCommand>> _loadCommands() async {
    FakeData fakeData = await _fakeDataRepository.load();
    List<TerminalCommand> commands = [];

    commands.add(CatCommand(fakeData.fakeFiles, (String url) => _contentRepository.load(url)));
    commands.add(ClearCommand());
    if (hasExitCommand()) {
      commands.add(ExitCommand(executeExitCommand));
    }
    if (JavascriptDom.instance?.canEvalJs() == true) {
      commands.add(JsCommand());
    }
    commands.add(HelpCommand(() => commands));
    commands.add(HistoryCommand());
    commands.add(LsCommand(fakeData.fakeFiles));
    commands.add(ManCommand(() => commands));

    fakeData.fakeCommands.forEach((fakeCommand) {
      commands.add(FakeCommandWrapper(fakeCommand, (String url) => _contentRepository.load(url)));
    });

    commands.sort((a, b) => a.name.compareTo(b.name));
    return commands;
  }

  @override
  bool hasExitCommand() {
    return JavascriptDom.instance?.canNavigateBack() == true;
  }

  @override
  void executeExitCommand() {
    _kLogger.fine("Exit Terminal invoked");
    if (hasExitCommand()) {
      JavascriptDom.instance?.navigateBack();
    }
  }

  @override
  String? autocomplete(String commandLine) {
    _kLogger.fine("Autocomplete invoked with commandLine=$commandLine");
    final commandWithArguments = _getCommandWithArguments(commandLine);
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

  @override
  Future<void> executeCommandLine(String commandLine, List<TerminalLine> output, List<String> history) async {
    _kLogger.fine("Execute command invoked with commandLine=$commandLine");

    // history pointer '!N' replacement
    if (commandLine.startsWith('!')) {
      output.add(_commandOutputLine(commandLine));
      final historyIndexString = commandLine.replaceFirst('!', '').split(" ").first;
      final historyIndex = int.tryParse(historyIndexString);
      if (historyIndex != null && historyIndex >= 0 && historyIndex < history.length) {
        commandLine = history.elementAt(historyIndex);
        _kLogger.fine("Replaced command from history commandLine=$commandLine");
      } else {
        output.add(_invalidHistoryIndexOutputLine(commandLine));
        return;
      }
    }

    final commandWithArguments = _getCommandWithArguments(commandLine);
    if (commandWithArguments.isEmpty) {
      output.add(_emptyOutputLine());
    } else {
      history.add(commandLine);
      output.add(_commandOutputLine(commandLine));
      await _executeCommand(commandWithArguments, output, history);
    }
  }

  Future<void> _executeCommand(
    List<String> commandWithArguments,
    List<TerminalLine> output,
    List<String> history,
  ) async {
    final commandName = commandWithArguments[0];
    commandWithArguments.removeAt(0);
    final arguments = commandWithArguments;
    final matches = _commands.where((command) => command.name == commandName);
    if (matches.isNotEmpty) {
      final command = matches.first;
      try {
        final outputList = await command.execute(arguments: arguments, history: history);
        final outputString = outputList
            .fold<String>("", (previousValue, element) => previousValue + "\n" + element)
            .replaceFirst("\n", "");
        output.add(TerminalLine(line: outputString, type: LineType.result));
      } on ExecuteClearCommand {
        output.clear();
      } on ExecuteClearHistoryCommand {
        history.clear();
      }
    } else {
      output.add(_commandNotFoundOutputLine(commandName));
    }
  }

  List<String> _getCommandWithArguments(String commandLine) =>
      commandLine.split(" ").map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

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
}
