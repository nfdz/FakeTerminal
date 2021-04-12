import 'dart:convert';

import 'package:fake_terminal_app/core/commands/local/fake_data.dart';
import 'package:flutter/services.dart';

abstract class CommandsLoader {
  Future<FakeData> loadCommandAssets();
}

class CommandsLoaderAssets extends CommandsLoader {
  static const _kFakeDataAssetFile = "assets/fake_data.json";

  @override
  Future<FakeData> loadCommandAssets() async {
    String dataJson = await rootBundle.loadString(_kFakeDataAssetFile);
    return FakeData.fromJson(jsonDecode(dataJson));
  }
}
