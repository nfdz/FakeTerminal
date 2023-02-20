// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminal_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminalLine _$TerminalLineFromJson(Map<String, dynamic> json) => TerminalLine(
      prefix: json['prefix'] as String?,
      line: json['line'] as String,
      type: $enumDecode(_$LineTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TerminalLineToJson(TerminalLine instance) => <String, dynamic>{
      'prefix': instance.prefix,
      'line': instance.line,
      'type': _$LineTypeEnumMap[instance.type]!,
    };

const _$LineTypeEnumMap = {
  LineType.command: 'command',
  LineType.result: 'result',
  LineType.timestamp: 'timestamp',
};
