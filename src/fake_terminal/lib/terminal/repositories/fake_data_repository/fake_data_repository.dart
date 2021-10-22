import 'dart:convert';

import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/asset_text_loader.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

final fakeDataRepositoryProvider =
    Provider<FakeDataRepository>((ref) => FakeDataRepositoryImpl(AssetTextLoaderImpl(rootBundle)));

abstract class FakeDataRepository {
  Future<FakeData> load();
}

final Logger _kLogger = Logger("FakeDataRepository");

class FakeDataRepositoryImpl extends FakeDataRepository {
  static const kFakeDataAssetFile = "assets/fake_data.json";

  final AssetTextLoader _assetloader;
  FakeDataRepositoryImpl(this._assetloader);

  @override
  Future<FakeData> load() async {
    try {
      String dataJson = await _assetloader.loadString(kFakeDataAssetFile);
      return FakeData.fromJson(jsonDecode(dataJson));
    } catch (error) {
      _kLogger.warning("Cannot load fake data Json file", error);
      return FakeData(fakeCommands: [], fakeFiles: []);
    }
  }
}
