import 'package:fake_terminal_app/model/command.dart';
import 'package:fake_terminal_app/model/terminal_content.dart';
import 'package:fake_terminal_app/utils/constants.dart';

class HistoryCommand extends Command {
  static HistoryCommand? _instance;

  factory HistoryCommand() {
    if (_instance == null) {
      _instance = HistoryCommand._();
    }
    return _instance!;
  }

  HistoryCommand._() : super(kCmdHistory, kCmdHistoryManEntry);

  @override
  void execute(
      List<String> args, List<TerminalLine> output, List<String> history) {
    if (args.length > 1) {
      output.insert(0, ResultLine(kCmdIgnoredArgs));
    }
    String historyOutput = "";
    int historyLength = history.length;
    for (int i = 0; i < historyLength; i++) {
      historyOutput += "   ${_formatIndex(i, historyLength)}  ${history[i]}\n";
    }
    output.insert(0, ResultLine(historyOutput));
  }

  String _formatIndex(int index, int length) {
    String lengthText = length.toString();
    int lengthMaxSize = lengthText.length;
    String indexText = index.toString();
    int indexSize = indexText.length;
    for (int i = 0; i < (lengthMaxSize - indexSize); i++) {
      indexText += " ";
    }
    return indexText;
  }
}

const String kCmdHistory = "history";
const String kCmdHistoryManEntry = """
HISTORY(1)

NAME
       history - show the history command list

SYNOPSIS
       history

DESCRIPTION
       The history command related to recently-executed commands recorded in a history list.

OPTIONS
       None.""";
