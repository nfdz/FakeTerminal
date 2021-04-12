import 'package:fake_terminal_app/core/commands/model/terminal_command.dart';

class ClearCommand extends TerminalCommand {
  final Function onClearTerminal;
  ClearCommand(this.onClearTerminal) : super(name: _kCommandName, manual: _kCommandManual);

  @override
  List<String> execute(List<String> arguments) {
    onClearTerminal();
    return [];
  }

  @override
  String? autocomplete(String argument) {
    return null;
  }
}

const String _kCommandName = "clear";
const String _kCommandManual = """
CLEAR(1)

NAME
       clear - clear the terminal screen

SYNOPSIS
       clear

DESCRIPTION
       clear clears your screen if this is possible, including its scrollback buffer.

HISTORY
       A clear command appeared in 2.79BSD dated February 24, 1979. Later that was provided in Unix 8th edition (1985).

OPTIONS
       None.""";
