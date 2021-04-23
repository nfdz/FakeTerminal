import 'package:fake_terminal/core/command_url/command_url_loader.dart';
import 'package:fake_terminal/core/commands/model/terminal_command.dart';
import 'package:fake_terminal/core/commands/special_commands/cat_command.dart';
import 'package:fake_terminal/core/commands/special_commands/clear_command.dart';
import 'package:fake_terminal/core/commands/special_commands/exit_command.dart';
import 'package:fake_terminal/core/commands/special_commands/help_command.dart';
import 'package:fake_terminal/core/commands/special_commands/history_command.dart';
import 'package:fake_terminal/core/commands/special_commands/ls_command.dart';
import 'package:fake_terminal/core/commands/special_commands/man_command.dart';
import 'package:fake_terminal/core/fake_data/fake_data_loader.dart';
import 'package:fake_terminal/core/fake_data/model/fake_data.dart';

abstract class CommandsLoader {
  Future<List<TerminalCommand>> load({
    required List<String> Function() getHistory,
    required Function? onExitTerminal,
  });
}

class CommandsLoaderWithFakeData extends CommandsLoader {
  final FakeDataLoader _fakeDataLoader = FakeDataLoaderFromAssets();
  final CommandUrlLoader _commandUrlLoader = CommandUrlLoaderFromHttp();

  @override
  Future<List<TerminalCommand>> load({
    required List<String> Function() getHistory,
    required Function? onExitTerminal,
  }) async {
    FakeData fakeData = await _fakeDataLoader.load();
    List<TerminalCommand> commands = [];
    commands.add(CatCommand(fakeData.fakeFiles, _commandUrlLoader));
    commands.add(ClearCommand());
    if (onExitTerminal != null) {
      commands.add(ExitCommand(onExitTerminal));
    }
    commands.add(HelpCommand(() => commands));
    commands.add(HistoryCommand(getHistory));
    commands.add(LsCommand(fakeData.fakeFiles));
    commands.add(ManCommand(() => commands));
    //fakeData.fakeCommands
    //
    return commands;
  }
}
