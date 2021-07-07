import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fake_data.g.dart';

@JsonSerializable()
class FakeData extends Equatable {
  @JsonKey(name: "fake_files")
  final List<FakeFile> fakeFiles;
  @JsonKey(name: "fake_commands")
  final List<FakeCommand> fakeCommands;

  FakeData({required this.fakeFiles, required this.fakeCommands});

  factory FakeData.fromJson(Map<String, dynamic> json) => _$FakeDataFromJson(json);
  Map<String, dynamic> toJson() => _$FakeDataToJson(this);

  @override
  List<Object?> get props => [fakeFiles, fakeCommands];
}

@JsonSerializable()
class FakeFile extends Equatable {
  final String name;
  @JsonKey(name: "content_url")
  final String? contentUrl;
  @JsonKey(name: "content")
  final String? content;
  FakeFile({
    required this.name,
    this.contentUrl,
    this.content,
  })  : assert(contentUrl != null || content != null),
        assert(!(contentUrl != null && content != null));

  factory FakeFile.fromJson(Map<String, dynamic> json) => _$FakeFileFromJson(json);
  Map<String, dynamic> toJson() => _$FakeFileToJson(this);

  @override
  List<Object?> get props => [name, contentUrl, content];
}

@JsonSerializable()
class FakeCommand extends Equatable {
  final String name;
  final String description;
  final List<FakeArgument> arguments;
  @JsonKey(name: "default_argument")
  final String defaultArgument;
  FakeCommand({
    required this.name,
    required this.description,
    required this.arguments,
    required this.defaultArgument,
  }) : assert(arguments.where((fakeArgument) => fakeArgument.name == defaultArgument).isNotEmpty);

  factory FakeCommand.fromJson(Map<String, dynamic> json) => _$FakeCommandFromJson(json);
  Map<String, dynamic> toJson() => _$FakeCommandToJson(this);

  @override
  List<Object?> get props => [name, description, arguments, defaultArgument];
}

@JsonSerializable()
class FakeArgument extends Equatable {
  final String name;
  final String description;
  @JsonKey(name: "output_url")
  final String? outputUrl;
  @JsonKey(name: "output")
  final String? output;
  FakeArgument({
    required this.name,
    required this.description,
    this.outputUrl,
    this.output,
  })  : assert(outputUrl != null || output != null),
        assert(!(outputUrl != null && output != null));

  factory FakeArgument.fromJson(Map<String, dynamic> json) => _$FakeArgumentFromJson(json);
  Map<String, dynamic> toJson() => _$FakeArgumentToJson(this);

  @override
  List<Object?> get props => [name, description, outputUrl, output];
}
