import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';

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
  void execute(List<String> args, List<TerminalLine> output, List<String> history) {
    output.clear();
  }
}

const String kCmdClear = "clear";
const String kCmdClearManEntry = """
CLEAR(1)

NAME
       clear - clear the terminal screen

SYNOPSIS
       clear

DESCRIPTION
       clear clears your screen if this is possible, including its scrollback buffer.

HISTORY
       A clear command appeared in 2.79BSD dated February 24, 1979. Later that was provided in Unix 8th edition (1985).

OPTIONS
       None.""";
