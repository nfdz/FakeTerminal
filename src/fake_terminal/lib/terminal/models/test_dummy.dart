import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_dummy.g.dart';

@JsonSerializable()
class TestDummy extends Equatable {
  final String name;
  TestDummy({
    required this.name,
  });

  factory TestDummy.fromJson(Map<String, dynamic> json) => _$TestDummyFromJson(json);
  Map<String, dynamic> toJson() => _$TestDummyToJson(this);

  @override
  List<Object?> get props => [name];
}
