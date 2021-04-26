import 'dart:math' as math;

import 'package:fake_terminal/terminal/models/terminal_command.dart';

class HelpCommand extends TerminalCommand {
  final List<TerminalCommand> Function() _getAllCommands;
  HelpCommand(this._getAllCommands)
      : super(
          name: _kCommandName,
          description: _kCommandDescription,
          manual: _kCommandManual,
        );

  @override
  Future<List<String>> execute({required List<String> arguments, required List<String> history}) async {
    final List<String> output = [_kHelpStart];
    final allCommands = _getAllCommands();
    allCommands.sort((a, b) => a.name.compareTo(b.name));
    final commandMaxLength = allCommands.map((command) => command.name.length).reduce(math.max);
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
    buffer.write(command.description);
    return buffer.toString();
  }

  @override
  String? autocomplete(String argument) {
    return null;
  }
}

const String _kCommandName = "help";
const String _kCommandDescription = "Show help information";
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
