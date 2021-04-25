import 'package:fake_terminal/terminal/models/terminal_command.dart';

class HistoryCommand extends TerminalCommand {
  final List<String> Function() _getHistory;
  HistoryCommand(this._getHistory)
      : super(
          name: _kCommandName,
          description: _kCommandDescription,
          manual: _kCommandManual,
        );

  @override
  Future<List<String>> execute(List<String> arguments) async {
    if (arguments.contains(_kClearArgument)) {
      throw new ExecuteClearHistoryCommand();
    }

    final List<String> output = [];
    final history = _getHistory();
    int historyLength = history.length;
    for (int i = 0; i < history.length; i++) {
      final index = _formatIndex(i, historyLength);
      output.add("$index  ${history[i]}");
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
    return _kClearArgument.startsWith(argument) ? _kClearArgument : null;
  }
}

class ExecuteClearHistoryCommand implements Exception {}

const String _kClearArgument = "-c";
const String _kCommandName = "history";
const String _kCommandDescription = "Show the history command list";
const String _kCommandManual = """
HISTORY(1)

NAME
       history - show the command list history

SYNOPSIS
       history [$_kClearArgument]

DESCRIPTION
       The history command related to recently-executed commands recorded in a history list.
       
       The options are as follows:
       
       $_kClearArgument      Clear the history.

OPTIONS
       None.""";
