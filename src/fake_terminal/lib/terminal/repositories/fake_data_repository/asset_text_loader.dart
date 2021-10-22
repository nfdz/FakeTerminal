import 'package:flutter/services.dart';

abstract class AssetTextLoader {
  Future<String> loadString(String key);
}

class AssetTextLoaderImpl extends AssetTextLoader {
  final AssetBundle _assetBundle;
  AssetTextLoaderImpl(this._assetBundle);

  @override
  Future<String> loadString(String key) => _assetBundle.loadString(key);
}
