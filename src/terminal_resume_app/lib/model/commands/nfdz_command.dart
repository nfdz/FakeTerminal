import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';

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
  void execute(List<String> args, List<TerminalLine> output, List<String> history) {
    // TODO: implement execute
  }
}

const String kCmdNfdz = "nfdz";
const String kCmdNfdzManEntry = """
NFDZ(1)

NAME
       nfdz - Processes the json files with information about me.

SYNOPSIS
       nfdz [OPTION]

OPTIONS
       about      - Know about me.
       education  - Know about my education.
       experience - Know about my work experience.
       hello      - Not greeting is unpolite.
       objectives - Know about my professional goals.
       skills     - Know about my professional skills.
       version    - the current operational version.""";
