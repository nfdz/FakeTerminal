import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';
import 'package:terminal_resume_app/utils/constants.dart';

class NfdzCommand extends Command {
  static NfdzCommand _instance;

  factory NfdzCommand() {
    if (_instance == null) {
      _instance = NfdzCommand._();
    }
    return _instance;
  }

  NfdzCommand._() : super(kCmdNfdz, kCmdNfdzManEntry);

  @override
  void execute(List<String> args, List<TerminalLine> output) {
    // TODO: implement execute
  }
}
