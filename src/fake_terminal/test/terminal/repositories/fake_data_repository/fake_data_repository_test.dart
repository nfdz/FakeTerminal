import 'package:fake_terminal/terminal/repositories/content_repository/content_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

void main() {
  group('provider', () {
    test('creation', () {
      final container = ProviderContainer();
      final providerInstance = container.readProviderElement(contentRepositoryProvider).state.createdValue;
      expect(providerInstance, isA<ContentRepositoryHttp>());
    });
  });

  group('load', () {
    test('given http then invoke GET and return its output', () async {
      final expectedOutput = "myOutput";
      var getCount = 0;
      Uri? invokedUrl;
      final httpGet = (Uri url) {
        invokedUrl = url;
        getCount++;
        return Future.value(expectedOutput);
      };

      final repository = ContentRepositoryHttp(httpGet);

      final urlToLoad = "myUrl.com";
      final result = await repository.load(urlToLoad);

      expect(getCount, 1);
      expect(invokedUrl!.path, urlToLoad);
      expect(result, expectedOutput);
    });

    test('given http and GET failed then return the given url', () async {
      final httpGet = (Uri url) => throw Exception("This is an error");

      final repository = ContentRepositoryHttp(httpGet);

      final urlToLoad = "myUrl.com";
      final result = await repository.load(urlToLoad);

      expect(result, urlToLoad);
    });
  });
}
