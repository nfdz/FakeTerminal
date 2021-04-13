import 'dart:convert';

import 'package:fake_terminal_app/core/commands/local/fake_data.dart';
import 'package:flutter/services.dart';

abstract class FakeDataLoader {
  Future<FakeData> load();
}

class FakeDataLoaderFromAssets extends FakeDataLoader {
  static const _kFakeDataAssetFile = "assets/fake_data.json";

  @override
  Future<FakeData> load() async {
    String dataJson = await rootBundle.loadString(_kFakeDataAssetFile);
    return FakeData.fromJson(jsonDecode(dataJson));
  }
}
