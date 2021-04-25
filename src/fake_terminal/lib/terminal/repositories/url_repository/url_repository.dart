import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

final urlRepositoryProvider = Provider<UrlRepository>((ref) => _UrlRepositoryHttp());

abstract class UrlRepository {
  Future<String> load(String url);
}

final Logger _kLogger = Logger("UrlRepository");

class _UrlRepositoryHttp extends UrlRepository {
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
