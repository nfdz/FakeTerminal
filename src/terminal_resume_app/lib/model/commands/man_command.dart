import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';
import 'package:terminal_resume_app/utils/constants.dart';

class ManCommand extends Command {
  static ManCommand _instance;

  factory ManCommand() {
    if (_instance == null) {
      _instance = ManCommand._();
    }
    return _instance;
  }

  ManCommand._() : super(kCmdMan, kCmdManManEntry);

  @override
  void execute(List<String> args, List<TerminalLine> output) {
    if (args.length < 2) {
      output.insert(0, ResultLine(kCmdInvalidArgs + cmd));
    } else {
      if (args.length > 2) {
        output.insert(0, ResultLine(kCmdIgnoredArgs));
      }
      String manArg = args[1];
      // if first arg is help option, man arg is the command
      if (manArg == kHelpArg) {
        manArg = args.first;
      }
      output.insert(0, ResultLine(_getManFor(manArg)));
    }
  }

  String _getManFor(String cmd) {
    Command command = parseCommand(cmd);
    return command != null ? command.manEntry : "$kCmdManNotFound$cmd";
  }
}

const String kCmdMan = "man";
const String kCmdManNotFound = "No manual entry for ";
const String kCmdManManEntry = """
MAN(1)

NAME
       man - an interface to the on-line reference manuals

SYNOPSIS
       man [CMD]

DESCRIPTION
       man is the system's manual pager.  Each page argument given to man is normally the name of a program, utility or function. The manual page associated with each of these arguments is then found and displayed.

EXAMPLES
       man ls
           Display the manual page for the item (program) ls.

DEFAULTS
       man will search for the desired manual pages within the index database caches.""";
