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
      output.insert(0, ResultLine(kCmdInvalidArgs + kCmdMan));
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
