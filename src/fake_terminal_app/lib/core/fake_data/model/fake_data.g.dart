// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fake_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FakeData _$FakeDataFromJson(Map<String, dynamic> json) {
  return FakeData(
    fakeFiles: (json['fake_files'] as List<dynamic>)
        .map((e) => TerminalLine.fromJson(e as Map<String, dynamic>))
        .toList(),
    fakeCommands: (json['fake_commands'] as List<dynamic>)
        .map((e) => TerminalLine.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FakeDataToJson(FakeData instance) => <String, dynamic>{
      'fake_files': instance.fakeFiles,
      'fake_commands': instance.fakeCommands,
    };

FakeFile _$FakeFileFromJson(Map<String, dynamic> json) {
  return FakeFile(
    name: json['name'] as String,
    contentUrl: json['content_url'] as String,
  );
}

Map<String, dynamic> _$FakeFileToJson(FakeFile instance) => <String, dynamic>{
      'name': instance.name,
      'content_url': instance.contentUrl,
    };

FakeCommand _$FakeCommandFromJson(Map<String, dynamic> json) {
  return FakeCommand(
    name: json['name'] as String,
    manual: json['manual'] as String,
    arguments: (json['arguments'] as List<dynamic>)
        .map((e) => FakeArgument.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FakeCommandToJson(FakeCommand instance) =>
    <String, dynamic>{
      'name': instance.name,
      'manual': instance.manual,
      'arguments': instance.arguments,
    };

FakeArgument _$FakeArgumentFromJson(Map<String, dynamic> json) {
  return FakeArgument(
    name: json['name'] as String,
    manual: json['manual'] as String,
    outputUrl: json['output_url'] as String,
  );
}

Map<String, dynamic> _$FakeArgumentToJson(FakeArgument instance) =>
    <String, dynamic>{
      'name': instance.name,
      'manual': instance.manual,
      'output_url': instance.outputUrl,
    };
