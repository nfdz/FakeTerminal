import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

abstract class CommandUrlLoader {
  Future<String> load(String url);
}

final Logger _kLogger = Logger("CommandUrlLoader");

class CommandUrlLoaderFromHttp extends CommandUrlLoader {
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
