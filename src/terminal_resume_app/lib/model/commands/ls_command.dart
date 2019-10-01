import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';
import 'package:terminal_resume_app/utils/constants.dart';

class LsCommand extends Command {
  static LsCommand _instance;

  factory LsCommand() {
    if (_instance == null) {
      _instance = LsCommand._();
    }
    return _instance;
  }

  LsCommand._() : super(kCmdLs, kCmdLsManEntry);

  @override
  void execute(List<String> args, List<TerminalLine> output) {
    if (args.length > 1) {
      output.insert(0, ResultLine(kCmdIgnoredArgs));
    }
    output.insert(0, ResultLine(kCmdLsOutput));
  }
}
