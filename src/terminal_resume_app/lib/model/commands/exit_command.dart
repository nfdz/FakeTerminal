import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';

class ExitCommand extends Command {
  static ExitCommand _instance;

  factory ExitCommand() {
    if (_instance == null) {
      _instance = ExitCommand._();
    }
    return _instance;
  }

  ExitCommand._() : super(kCmdExit, kCmdExitManEntry);

  @override
  void execute(List<String> args, List<TerminalLine> output) {
    // TODO: implement execute
  }
}

const String kCmdExit = "exit";
const String kCmdExitManEntry = """
EXIT(1)

NAME
       exit - cause the shell to exit

SYNOPSIS
       exit

DESCRIPTION
       The exit utility shall cause the shell to exit with the exit status specified by the unsigned decimal integer n.  If n is specified, but its value is not between 0 and 255 inclusively, the exit status is undefined.

OPTIONS
       None.""";
