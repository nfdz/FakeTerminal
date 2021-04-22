import 'package:fake_terminal_app/core/commands/model/terminal_command.dart';

class ManCommand extends TerminalCommand {
  final List<TerminalCommand> Function() _getAllCommands;
  ManCommand(this._getAllCommands)
      : super(
          name: _kCommandName,
          description: _kCommandDescription,
          manual: _kCommandManual,
        );

  @override
  Future<List<String>> execute(List<String> arguments) async {
    if (arguments.isEmpty) {
      return [_kCommandInvalid];
    }
    final allCommands = _getAllCommands();
    return arguments.map((argument) => _getManFor(argument, allCommands)).toList();
  }

  String _getManFor(String argument, List<TerminalCommand> allCommands) {
    final matches = allCommands.where((command) => command.name == argument);
    if (matches.isNotEmpty) {
      return matches.first.manual;
    } else {
      return _kCommandNotFoundOutputFor + argument;
    }
  }

  @override
  String? autocomplete(String argument) {
    final matches = _getAllCommands().where((command) => command.name.startsWith(argument));
    if (matches.isNotEmpty) {
      return matches.first.name;
    } else {
      return null;
    }
  }
}

const String _kCommandName = "man";
const String _kCommandDescription = "An interface to the reference manuals";
const String _kCommandManual = """
MAN(1)

NAME
       man - an interface to the reference manuals

SYNOPSIS
       man [CMD]

DESCRIPTION
       man is the system's manual pager.  Each page argument given to man is normally the name of a program, utility or function. The manual page associated with each of these arguments is then found and displayed.

EXAMPLES
       man ls
           Display the manual page for the item (program) ls.

DEFAULTS
       man will search for the desired manual pages within the index database caches.""";
const String _kCommandInvalid = "Input argument required, to learn about this command use: man man";
const String _kCommandNotFoundOutputFor = "No manual entry for ";
