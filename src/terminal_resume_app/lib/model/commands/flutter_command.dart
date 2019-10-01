import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';
import 'package:terminal_resume_app/utils/constants.dart';

class FlutterCommand extends Command {
  static FlutterCommand _instance;

  factory FlutterCommand() {
    if (_instance == null) {
      _instance = FlutterCommand._();
    }
    return _instance;
  }

  FlutterCommand._() : super(kCmdFlutter, kCmdFlutterManEntry);

  @override
  void execute(List<String> args, List<TerminalLine> output) {
    // TODO: implement execute
  }
}
