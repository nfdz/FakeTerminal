import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

final contentRepositoryProvider = Provider<ContentRepository>((ref) => _ContentRepositoryHttp());

abstract class ContentRepository {
  Future<String> load(String url);
}

final Logger _kLogger = Logger("UrlRepository");

class _ContentRepositoryHttp extends ContentRepository {
  @override
  Future<String> load(String url) async {
    try {
      return await http.read(Uri.parse(url));
    } on Exception catch (cause) {
      _kLogger.warning("Cannot load url: $url", cause);
      return url;
    }
  }
}
