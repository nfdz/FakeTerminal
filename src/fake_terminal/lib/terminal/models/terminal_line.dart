import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terminal_line.g.dart';

@JsonSerializable()
class TerminalLine extends Equatable {
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

  @override
  List<Object?> get props => [prefix, line, type];
}

enum LineType {
  command,
  result,
  timestamp,
}
