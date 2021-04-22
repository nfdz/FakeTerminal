import 'package:fake_terminal_app/core/terminal/model/terminal_line.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terminal_history.g.dart';

@JsonSerializable()
class TerminalHistory {
  final List<TerminalLine> output;
  final List<String> historyInput;
  final int timestampMillis;
  TerminalHistory({
    required this.output,
    required this.historyInput,
    required this.timestampMillis,
  });

  factory TerminalHistory.fromJson(Map<String, dynamic> json) => _$TerminalHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$TerminalHistoryToJson(this);
}
