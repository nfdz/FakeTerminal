import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands/commands.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/exit_executor.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/javascript_executor.dart';
import 'package:fake_terminal/terminal/repositories/content_repository/content_repository.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/fake_data_repository.dart';

abstract class CommandsLoader {
  Future<List<TerminalCommand>> loadCommands();
}

class CommandsLoaderImpl extends CommandsLoader {
  final FakeDataRepository _fakeDataRepository;
  final ContentRepository _contentRepository;
  final ExitExecutor _exitExecutor;
  final JavascriptExecutor? _javascriptExecutor;

  CommandsLoaderImpl(
    this._fakeDataRepository,
    this._contentRepository,
    this._exitExecutor,
    this._javascriptExecutor,
  );

  @override
  Future<List<TerminalCommand>> loadCommands() async {
    FakeData fakeData = await _fakeDataRepository.load();
    return _createCommands(
      fakeData: fakeData,
      contentRepository: _contentRepository,
      hasExitCommand: _exitExecutor.hasExitCommand(),
      executeExitCommand: _exitExecutor.executeExitCommand,
    );
  }

  List<TerminalCommand> _createCommands({
    required FakeData fakeData,
    required ContentRepository contentRepository,
    required bool hasExitCommand,
    required Function executeExitCommand,
  }) {
    List<TerminalCommand> commands = [];

    commands.add(CatCommand(fakeData.fakeFiles, (String url) => contentRepository.load(url)));
    commands.add(ClearCommand());
    if (hasExitCommand) {
      commands.add(ExitCommand(executeExitCommand));
    }
    if (_javascriptExecutor != null) {
      commands.add(JsCommand(_javascriptExecutor!));
    }
    commands.add(HelpCommand(() => commands));
    commands.add(HistoryCommand());
    commands.add(LsCommand(fakeData.fakeFiles));
    commands.add(ManCommand(() => commands));

    fakeData.fakeCommands.forEach((fakeCommand) {
      commands.add(FakeCommandWrapper(fakeCommand, (String url) => contentRepository.load(url)));
    });

    commands.sort((a, b) => a.name.compareTo(b.name));
    return commands;
  }
}
