import 'package:fake_terminal_app/core/commands/model/terminal_command.dart';

class ExitCommand extends TerminalCommand {
  final Function onExitTerminal;
  ExitCommand(this.onExitTerminal) : super(name: _kCommandName, manual: _kCommandManual);

  @override
  List<String> execute(List<String> arguments) {
    onExitTerminal();
    return [];
  }

  String? autocomplete(String argument) {
    return null;
  }
}

const String _kCommandName = "exit";
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
