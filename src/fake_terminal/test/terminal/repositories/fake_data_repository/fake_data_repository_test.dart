import 'dart:convert';

import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/fake_data_repository.dart';
import 'package:flutter/services.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'fake_data_repository_test.mocks.dart';

@GenerateMocks([AssetBundle])
void main() {
  group('provider', () {
    test('creation', () {
      final container = ProviderContainer();
      final providerInstance = container.readProviderElement(fakeDataRepositoryProvider).state.createdValue;
      expect(providerInstance, isA<FakeDataRepositoryImpl>());
    });
  });

  group('load', () {
    test('given AssetBundle then invoke loadString and return the expected FakeData', () async {
      final expectedFakeData = FakeData(
        fakeCommands: [
          FakeCommand(name: "name", description: "description", arguments: [], defaultArgument: "defaultArgument"),
        ],
        fakeFiles: [
          FakeFile(name: "name", content: "content"),
        ],
      );

      final assetBundle = MockAssetBundle();
      when(assetBundle.loadString(any)).thenAnswer((_) async => jsonEncode(expectedFakeData.toJson()));

      final repository = FakeDataRepositoryImpl(assetBundle);
      final result = await repository.load();

      expect(result, expectedFakeData);
      verify(assetBundle.loadString(FakeDataRepositoryImpl.kFakeDataAssetFile)).called(1);
    });

    test('given AssetBundleis is empty then return empty FakeData', () async {
      final assetBundle = MockAssetBundle();
      when(assetBundle.loadString(any)).thenAnswer((_) async => "");

      final repository = FakeDataRepositoryImpl(assetBundle);
      final result = await repository.load();

      expect(result, FakeData(fakeCommands: [], fakeFiles: []));
    });

    test('given AssetBundle failed then return empty FakeData', () async {
      final assetBundle = MockAssetBundle();
      when(assetBundle.loadString(any)).thenThrow(Exception("This is an error"));

      final repository = FakeDataRepositoryImpl(assetBundle);
      final result = await repository.load();

      expect(result, FakeData(fakeCommands: [], fakeFiles: []));
    });
  });
}
