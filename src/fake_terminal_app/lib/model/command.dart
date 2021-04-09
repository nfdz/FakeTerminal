import 'package:fake_terminal_app/model/commands/cat_command.dart';
import 'package:fake_terminal_app/model/commands/clear_command.dart';
import 'package:fake_terminal_app/model/commands/exit_command.dart';
import 'package:fake_terminal_app/model/commands/flutter_command.dart';
import 'package:fake_terminal_app/model/commands/help_command.dart';
import 'package:fake_terminal_app/model/commands/history_command.dart';
import 'package:fake_terminal_app/model/commands/ls_command.dart';
import 'package:fake_terminal_app/model/commands/man_command.dart';
import 'package:fake_terminal_app/model/commands/nfdz_command.dart';
import 'package:fake_terminal_app/model/terminal_content.dart';

abstract class Command {
  final String cmd;
  final String manEntry;
  Command(this.cmd, this.manEntry);
  void execute(
      List<String> args, List<TerminalLine> output, List<String> history);
}

final List<Command> kAvailableCommands = [
  HelpCommand(),
  NfdzCommand(),
  FlutterCommand(),
  ManCommand(),
  CatCommand(),
  ClearCommand(),
  ExitCommand(),
  LsCommand(),
  HistoryCommand(),
];

Command? parseCommand(String cmd) {
  for (Command availableCommand in kAvailableCommands) {
    if (availableCommand.cmd == cmd) {
      return availableCommand;
    }
  }
  return null;
}
