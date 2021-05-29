import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:test/test.dart';

void main() {
  group('FakeFile', () {
    test('constructor fails if there is no content neither url', () async {
      var creationFailed = false;
      try {
        FakeFile(name: "name");
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });

    test('constructor fails if there is content and url at the same time', () async {
      var creationFailed = false;
      try {
        FakeFile(name: "name", content: "content", contentUrl: "url");
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });
  });

  group('FakeArgument', () {
    test('constructor fails if there is no output neither url', () async {
      var creationFailed = false;
      try {
        FakeArgument(name: "name", description: "description");
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });

    test('constructor fails if there is output and url at the same time', () async {
      var creationFailed = false;
      try {
        FakeArgument(name: "name", description: "description", output: "content", outputUrl: "url");
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });
  });
}
