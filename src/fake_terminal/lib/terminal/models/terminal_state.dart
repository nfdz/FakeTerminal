import 'package:equatable/equatable.dart';
import 'package:fake_terminal/terminal/models/terminal_history.dart';
import 'package:fake_terminal/terminal/models/terminal_line.dart';

class TerminalState extends Equatable {
  final List<TerminalLine> output;
  final List<String> historyInput;

  TerminalState({
    required this.output,
    required this.historyInput,
  });

  TerminalHistory snapshot() => TerminalHistory(
        output: output.where((line) => line.type != LineType.timestamp).toList(),
        historyInput: historyInput,
        timestampMillis: DateTime.now().millisecondsSinceEpoch,
      );

  @override
  List<Object?> get props => [output, historyInput];
}
