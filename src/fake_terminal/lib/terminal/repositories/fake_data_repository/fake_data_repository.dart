import 'dart:convert';

import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';

final fakeDataRepositoryProvider = Provider<FakeDataRepository>((ref) => _FakeDataRepositoryAssets());

abstract class FakeDataRepository {
  Future<FakeData> load();
}

class _FakeDataRepositoryAssets extends FakeDataRepository {
  static const _kFakeDataAssetFile = "assets/fake_data.json";

  @override
  Future<FakeData> load() async {
    String dataJson = await rootBundle.loadString(_kFakeDataAssetFile);
    return FakeData.fromJson(jsonDecode(dataJson));
  }
}
