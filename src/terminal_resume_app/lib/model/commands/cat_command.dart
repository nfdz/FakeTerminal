import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';
import 'package:terminal_resume_app/utils/constants.dart';

class CatCommand extends Command {
  static CatCommand _instance;

  factory CatCommand() {
    if (_instance == null) {
      _instance = CatCommand._();
    }
    return _instance;
  }

  CatCommand._() : super(kCmdCat, kCmdCatManEntry);

  @override
  void execute(List<String> args, List<TerminalLine> output) {
    // TODO: implement execute
  }
}
