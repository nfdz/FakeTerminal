// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminal_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminalLine _$TerminalLineFromJson(Map<String, dynamic> json) {
  return TerminalLine(
    line: json['line'] as String,
    type: _$enumDecode(_$LineTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$TerminalLineToJson(TerminalLine instance) =>
    <String, dynamic>{
      'line': instance.line,
      'type': _$LineTypeEnumMap[instance.type],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$LineTypeEnumMap = {
  LineType.command: 'command',
  LineType.result: 'result',
};
