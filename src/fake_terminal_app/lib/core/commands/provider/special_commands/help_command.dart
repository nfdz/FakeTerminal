import 'dart:math' as Math;

import 'package:fake_terminal_app/core/commands/model/terminal_command.dart';

class HelpCommand extends TerminalCommand {
  final List<TerminalCommand> Function() getAllCommands;
  HelpCommand(this.getAllCommands) : super(name: _kCommandName, manual: _kCommandManual);

  @override
  List<String> execute(List<String> arguments) {
    final List<String> output = [_kHelpStart];
    final allCommands = getAllCommands();
    allCommands.sort((a, b) => a.name.compareTo(b.name));
    final commandMaxLength = allCommands.map((command) => command.name.length).reduce(Math.max);
    for (final command in allCommands) {
      output.add(_getCommandHelp(command, commandMaxLength));
    }
    return output;
  }

  String _getCommandHelp(TerminalCommand command, int commandMaxLength) {
    final buffer = StringBuffer();
    buffer.write(command.name);
    buffer.write(" " * (commandMaxLength - command.name.length));
    buffer.write(" - ");
    buffer.write(command.manual);
    return buffer.toString();
  }

  @override
  String? autocomplete(String argument) {
    return null;
  }
}

const String _kCommandName = "help";
const String _kCommandManual = """
HELP(1)

NAME
       help - Print help for working enviroment.

SYNOPSIS
       help

DESCRIPTION
       List information about the work options of current working enviroment.

OPTIONS
       None.""";
const String _kHelpStart = "The commands that are enabled are the following:";
