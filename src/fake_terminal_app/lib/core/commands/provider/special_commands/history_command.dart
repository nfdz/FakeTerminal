import 'package:fake_terminal_app/core/commands/model/terminal_command.dart';

class HistoryCommand extends TerminalCommand {
  final List<String> Function() getHistory;
  HistoryCommand(this.getHistory) : super(name: _kCommandName, manual: _kCommandManual);

  @override
  List<String> execute(List<String> arguments) {
    final List<String> output = [];
    final history = getHistory();
    int historyLength = history.length;
    for (int i = 0; i < history.length; i++) {
      final index = _formatIndex(i, historyLength);
      output.add("$index  ${history[i]}\n");
    }
    return output;
  }

  String _formatIndex(int index, int length) {
    String lengthText = length.toString();
    int lengthMaxSize = lengthText.length;
    String indexText = index.toString();
    int indexSize = indexText.length;
    final spacing = " " * (lengthMaxSize - indexSize);
    return indexText + spacing;
  }

  @override
  String? autocomplete(String argument) {
    return null;
  }
}

const String _kCommandName = "history";
const String _kCommandManual = """
HISTORY(1)

NAME
       history - show the history command list

SYNOPSIS
       history

DESCRIPTION
       The history command related to recently-executed commands recorded in a history list.

OPTIONS
       None.""";
