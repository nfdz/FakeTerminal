import 'package:terminal_resume_app/model/commands/cat_command.dart';
import 'package:terminal_resume_app/model/commands/clear_command.dart';
import 'package:terminal_resume_app/model/commands/exit_command.dart';
import 'package:terminal_resume_app/model/commands/flutter_command.dart';
import 'package:terminal_resume_app/model/commands/help_command.dart';
import 'package:terminal_resume_app/model/commands/ls_command.dart';
import 'package:terminal_resume_app/model/commands/man_command.dart';
import 'package:terminal_resume_app/model/commands/nfdz_command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';

abstract class Command {
  final String cmd;
  final String manEntry;
  Command(this.cmd, this.manEntry);
  void execute(List<String> args, List<TerminalLine> output);
}

final List<Command> kAvailableCommands = [
  CatCommand(),
  ClearCommand(),
  ExitCommand(),
  FlutterCommand(),
  HelpCommand(),
  LsCommand(),
  ManCommand(),
  NfdzCommand(),
];

Command parseCommand(String cmd) {
  for (Command availableCommand in kAvailableCommands) {
    if (availableCommand.cmd == cmd) {
      return availableCommand;
    }
  }
  return null;
}
