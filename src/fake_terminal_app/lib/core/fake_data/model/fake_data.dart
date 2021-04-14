import 'package:json_annotation/json_annotation.dart';

part 'fake_data.g.dart';

@JsonSerializable()
class FakeData {
  @JsonKey(name: "fake_files")
  final List<FakeFile> fakeFiles;
  @JsonKey(name: "fake_commands")
  final List<FakeCommand> fakeCommands;

  FakeData({required this.fakeFiles, required this.fakeCommands});

  factory FakeData.fromJson(Map<String, dynamic> json) => _$FakeDataFromJson(json);
  Map<String, dynamic> toJson() => _$FakeDataToJson(this);
}

@JsonSerializable()
class FakeFile {
  final String name;
  @JsonKey(name: "content_url")
  final String contentUrl;
  FakeFile({required this.name, required this.contentUrl});

  factory FakeFile.fromJson(Map<String, dynamic> json) => _$FakeFileFromJson(json);
  Map<String, dynamic> toJson() => _$FakeFileToJson(this);
}

@JsonSerializable()
class FakeCommand {
  final String name;
  final String description;
  final List<FakeArgument> arguments;
  FakeCommand({required this.name, required this.description, required this.arguments});

  factory FakeCommand.fromJson(Map<String, dynamic> json) => _$FakeCommandFromJson(json);
  Map<String, dynamic> toJson() => _$FakeCommandToJson(this);
}

@JsonSerializable()
class FakeArgument {
  final String name;
  final String manual;
  @JsonKey(name: "output_url")
  final String outputUrl;
  FakeArgument({required this.name, required this.manual, required this.outputUrl});

  factory FakeArgument.fromJson(Map<String, dynamic> json) => _$FakeArgumentFromJson(json);
  Map<String, dynamic> toJson() => _$FakeArgumentToJson(this);
}
