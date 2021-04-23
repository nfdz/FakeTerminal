import 'package:fake_terminal/core/commands/model/terminal_command.dart';

class ExitCommand extends TerminalCommand {
  final Function _onExitTerminal;
  ExitCommand(this._onExitTerminal)
      : super(
          name: _kCommandName,
          description: _kCommandDescription,
          manual: _kCommandManual,
        );

  @override
  Future<List<String>> execute(List<String> arguments) async {
    _onExitTerminal();
    return [];
  }

  String? autocomplete(String argument) {
    return null;
  }
}

const String _kCommandName = "exit";
const String _kCommandDescription = "Log off and close the shell";
const String _kCommandManual = """
EXIT(1)

NAME
       exit - cause the shell to exit

SYNOPSIS
       exit

DESCRIPTION
       The exit utility shall cause the shell to exit with the exit status specified by the unsigned decimal integer n.  If n is specified, but its value is not between 0 and 255 inclusively, the exit status is undefined.

OPTIONS
       None.""";
