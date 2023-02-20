import 'dart:convert';

import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/asset_text_loader.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/fake_data_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'fake_data_repository_test.mocks.dart';

@GenerateMocks([AssetTextLoader])
void main() {
  group('provider', () {
    test('creation', () {
      final container = ProviderContainer();
      final providerInstance = container.read(fakeDataRepositoryProvider);
      expect(providerInstance, isA<FakeDataRepositoryImpl>());
    });
  });

  group('load', () {
    test('given AssetTextLoader then invoke loadString and return the expected FakeData', () async {
      final expectedFakeData = FakeData(
        fakeCommands: [
          FakeCommand(
            name: "name",
            description: "description",
            arguments: [FakeArgument(name: "", description: "argDescription", output: "argOutput")],
            defaultArgument: "",
          ),
        ],
        fakeFiles: [
          FakeFile(name: "name", content: "content"),
        ],
      );

      final assetloader = MockAssetTextLoader();
      when(assetloader.loadString(any)).thenAnswer((_) async => jsonEncode(expectedFakeData.toJson()));

      final repository = FakeDataRepositoryImpl(assetloader);
      final result = await repository.load();

      expect(result, expectedFakeData);
      verify(assetloader.loadString(FakeDataRepositoryImpl.kFakeDataAssetFile)).called(1);
    });

    test('given AssetBundleis is empty then return empty FakeData', () async {
      final assetloader = MockAssetTextLoader();
      when(assetloader.loadString(any)).thenAnswer((_) async => "");

      final repository = FakeDataRepositoryImpl(assetloader);
      final result = await repository.load();

      expect(result, FakeData(fakeCommands: [], fakeFiles: []));
    });

    test('given AssetBundle failed then return empty FakeData', () async {
      final assetloader = MockAssetTextLoader();
      when(assetloader.loadString(any)).thenThrow(Exception("This is an error"));

      final repository = FakeDataRepositoryImpl(assetloader);
      final result = await repository.load();

      expect(result, FakeData(fakeCommands: [], fakeFiles: []));
    });
  });
}
