import 'package:fake_terminal/terminal/models/terminal_command.dart';

class ClearCommand extends TerminalCommand {
  ClearCommand()
      : super(
          name: _kCommandName,
          description: _kCommandDescription,
          manual: _kCommandManual,
        );

  @override
  Future<List<String>> execute({required List<String> arguments, required List<String> history}) async {
    throw new ExecuteClearCommand();
  }

  @override
  String? autocomplete(String argument) {
    return null;
  }
}

class ExecuteClearCommand implements Exception {}

const String _kCommandName = "clear";
const String _kCommandDescription = "Clear the terminal screen";
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
