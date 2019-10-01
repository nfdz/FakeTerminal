import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';
import 'package:terminal_resume_app/utils/constants.dart';

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
