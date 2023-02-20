// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminal_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminalHistory _$TerminalHistoryFromJson(Map<String, dynamic> json) => TerminalHistory(
      output: (json['output'] as List<dynamic>).map((e) => TerminalLine.fromJson(e as Map<String, dynamic>)).toList(),
      historyInput: (json['historyInput'] as List<dynamic>).map((e) => e as String).toList(),
      timestampMillis: json['timestampMillis'] as int,
    );

Map<String, dynamic> _$TerminalHistoryToJson(TerminalHistory instance) => <String, dynamic>{
      'output': instance.output,
      'historyInput': instance.historyInput,
      'timestampMillis': instance.timestampMillis,
    };
