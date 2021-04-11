import 'package:json_annotation/json_annotation.dart';

part 'terminal_line.g.dart';

@JsonSerializable()
class TerminalLine {
  final String? prefix;
  final String line;
  final LineType type;

  TerminalLine({
    this.prefix,
    required this.line,
    required this.type,
  });

  factory TerminalLine.fromJson(Map<String, dynamic> json) => _$TerminalLineFromJson(json);
  Map<String, dynamic> toJson() => _$TerminalLineToJson(this);
}

enum LineType {
  command,
  result,
}
