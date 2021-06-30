import 'dart:async';

import 'package:fake_terminal/plugins/javascript_dom/javascript_dom.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';
import 'package:fake_terminal/terminal/models/terminal_line.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/code_repository_executor.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands/commands.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_loader.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/exit_executor.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/javascript_executor.dart';
import 'package:fake_terminal/terminal/repositories/content_repository/content_repository.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/fake_data_repository.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

final commandsRepositoryProvider = Provider<CommandsRepository>((ref) {
  final fakeDataRepository = ref.read(fakeDataRepositoryProvider);
  final contentRepository = ref.read(contentRepositoryProvider);
  final exitExecutor = ExitExecutorImpl(JavascriptDom.instance);
  final codeRepoExecutor = CodeRepositoryExecutorImpl();
  final javascriptExecutor = JavascriptDom.instance != null ? JavascriptExecutorImpl(JavascriptDom.instance!) : null;
  final commandsLoader = CommandsLoaderImpl(
    fakeDataRepository,
    contentRepository,
    exitExecutor,
    javascriptExecutor,
  );
  return CommandsRepositoryFakeData(commandsLoader, exitExecutor, codeRepoExecutor);
});

final Logger _kLogger = Logger("CommandsRepository");

typedef HasExitCommandFunction = bool Function();
typedef ExecuteExitCommandFunction = void Function();

abstract class CommandsRepository {
  bool hasExitCommand();
  void executeExitCommand();
  void executeOpenRepositoryCommand();
  String? autocomplete(String commandLine);
  Future<void> executeCommandLine(String commandLine, List<TerminalLine> output, List<String> history);
}

class CommandsRepositoryFakeData extends CommandsRepository {
  Future get initializationComplete => _initCompleter.future;
  final _initCompleter = Completer();
  final CommandsLoader _commandsLoader;
  final ExitExecutor _exitExecutor;
  final CodeRepositoryExecutor _codeRepoExecutor;

  List<TerminalCommand> _commands = [];

  CommandsRepositoryFakeData(
    this._commandsLoader,
    this._exitExecutor,
    this._codeRepoExecutor,
  ) {
    _init(_commandsLoader).whenComplete(() => _initCompleter.complete());
  }

  Future<void> _init(CommandsLoader commandsLoader) async {
    _commands = await _commandsLoader.loadCommands();
  }

  @override
  bool hasExitCommand() => _exitExecutor.hasExitCommand();

  @override
  void executeExitCommand() => _exitExecutor.executeExitCommand();

  @override
  void executeOpenRepositoryCommand() => _codeRepoExecutor.executeOpenRepositoryCommand();

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
