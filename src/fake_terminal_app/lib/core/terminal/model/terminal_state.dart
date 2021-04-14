import 'package:fake_terminal_app/core/terminal/model/terminal_history.dart';
import 'package:fake_terminal_app/core/terminal/model/terminal_line.dart';

class TerminalState {
  final List<TerminalLine> output;
  final List<String> historyInput;
  final String? input;

  TerminalState({
    required this.output,
    required this.historyInput,
    this.input,
  });

  TerminalHistory snapshot() => TerminalHistory(
        output: output.where((line) => line.type != LineType.timestamp).toList(),
        historyInput: historyInput,
        timestampMillis: DateTime.now().millisecondsSinceEpoch,
      );
}
