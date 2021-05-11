import 'package:fake_terminal/plugins/javascript_dom/javascript_dom.dart';
import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands/commands.dart';
import 'package:fake_terminal/terminal/repositories/content_repository/content_repository.dart';

abstract class FakeDataToCommands {
  List<TerminalCommand> createCommands({
    required FakeData fakeData,
    required ContentRepository contentRepository,
    required bool hasExitCommand,
    required Function executeExitCommand,
  });
}

class FakeDataToCommandsImpl extends FakeDataToCommands {
  @override
  List<TerminalCommand> createCommands({
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
    if (JavascriptDom.instance?.canEvalJs() == true) {
      commands.add(JsCommand());
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
