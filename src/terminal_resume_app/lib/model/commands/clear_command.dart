import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';
import 'package:terminal_resume_app/utils/constants.dart';

class ClearCommand extends Command {
  static ClearCommand _instance;

  factory ClearCommand() {
    if (_instance == null) {
      _instance = ClearCommand._();
    }
    return _instance;
  }

  ClearCommand._() : super(kCmdClear, kCmdClearManEntry);

  @override
  void execute(List<String> args, List<TerminalLine> output) {
    output.clear();
  }
}
