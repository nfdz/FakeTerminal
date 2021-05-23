import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

final contentRepositoryProvider = Provider<ContentRepository>((ref) => ContentRepositoryHttp(http.read));

abstract class ContentRepository {
  Future<String> load(String url);
}

final Logger _kLogger = Logger("UrlRepository");

typedef HttpGet = Future<String> Function(Uri url);

class ContentRepositoryHttp extends ContentRepository {
  final HttpGet _httpGet;
  ContentRepositoryHttp(this._httpGet);

  @override
  Future<String> load(String url) async {
    try {
      return await _httpGet(Uri.parse(url));
    } on Exception catch (cause) {
      _kLogger.warning("Cannot load url: $url", cause);
      return url;
    }
  }
}
