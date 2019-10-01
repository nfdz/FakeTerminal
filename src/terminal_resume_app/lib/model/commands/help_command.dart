import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';
import 'package:terminal_resume_app/utils/constants.dart';

class HelpCommand extends Command {
  static HelpCommand _instance;

  factory HelpCommand() {
    if (_instance == null) {
      _instance = HelpCommand._();
    }
    return _instance;
  }

  HelpCommand._() : super(kCmdHelp, kCmdHelpManEntry);

  @override
  void execute(List<String> args, List<TerminalLine> output, List<String> history) {
    if (args.length > 1) {
      output.insert(0, ResultLine(kCmdIgnoredArgs));
    }
    output.insert(0, ResultLine(kCmdHelpOutput));
  }
}

const String kCmdHelp = "help";
const String kCmdHelpOutput = """
The commands that are enabled are the following:
 cat     - Concatenate FILE(s) to standard output
 clear   - Clear the terminal screen
 exit    - Log off and close the app
 flutter - Flutter app development
 help    - Show help information about terminal
 history - Show the history command list
 ls      - List directory contents
 man     - An interface to the on-line reference manuals
 nfdz    - Processes the json files with information about me""";
const String kCmdHelpManEntry = """
HELP(1)

NAME
       help - Print help for working enviroment.

SYNOPSIS
       help

DESCRIPTION
       List information about the work options of current working enviroment.

OPTIONS
       None.""";
