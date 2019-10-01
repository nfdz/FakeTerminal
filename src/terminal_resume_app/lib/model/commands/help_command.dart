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
  void execute(List<String> args, List<TerminalLine> output) {
    if (args.length > 1) {
      output.insert(0, ResultLine(kCmdIgnoredArgs));
    }
    output.insert(0, ResultLine(kCmdHelpOutput));
  }
}
