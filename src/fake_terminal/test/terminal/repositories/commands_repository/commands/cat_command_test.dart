import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands/cat_command.dart';
import 'package:test/test.dart';

void main() {
  group('execute', () {
    test('given no arguments then return invalid message', () async {
      final command = CatCommand([], (_) async => "");
      expect(await command.execute(arguments: [], history: []), [CatCommand.commandInvalid]);
    });

    test('given argument a file that does not exist then return file not found message', () async {
      final argument = "myFile";
      final command = CatCommand([], (_) async => "");
      expect(await command.execute(arguments: [argument], history: []), [CatCommand.fileNotFoundOutput(argument)]);
    });

    test('given argument a file that exist then return file content', () async {
      final fileName = "myFile";
      final fileContent = "This is the content";
      final file = FakeFile(name: fileName, content: fileContent);
      final command = CatCommand([file], (_) async => "");
      expect(await command.execute(arguments: [fileName], history: []), [fileContent]);
    });

    test('given argument a file with remote content then fetch the content and return it', () async {
      final fileName = "myFile";
      final fileContentUrl = "http://thecontentis.here";
      final remoteContent = "This is the content";
      int fetchUrlCounter = 0;
      final file = FakeFile(name: fileName, contentUrl: fileContentUrl);
      final command = CatCommand([file], (url) async {
        expect(url, fileContentUrl);
        fetchUrlCounter++;
        return remoteContent;
      });
      expect(await command.execute(arguments: [fileName], history: []), [remoteContent]);
      expect(fetchUrlCounter, 1);
    });
  });

  group('autocomplete', () {
    test('given argument a file that does not exist then return null', () async {
      final fileName = "myFile";
      final command = CatCommand([], (_) async => "");
      expect(command.autocomplete(fileName), null);
    });

    test('given argument half name of a file that exist then return file name', () async {
      final fileName = "myFile";
      final fileContent = "This is the content";
      final file = FakeFile(name: fileName, content: fileContent);
      final command = CatCommand([file], (_) async => "");
      expect(command.autocomplete("my"), fileName);
    });
  });
}
