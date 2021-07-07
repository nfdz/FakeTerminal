import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands/fake_command_wrapper.dart';
import 'package:test/test.dart';

void main() {
  group('execute', () {
    test('given no argument then execute defaultArgument and return the content', () async {
      final defaultArgOutput = "The content";
      final fakeCommand = FakeCommand(
        name: "commandName",
        description: "theDescription",
        arguments: [FakeArgument(name: "", description: "argDescription", output: defaultArgOutput)],
        defaultArgument: "",
      );
      final command = FakeCommandWrapper(fakeCommand, (_) async => "");
      expect(await command.execute(arguments: [], history: []), [defaultArgOutput]);
    });

    test('given argument that do not exist then return invalid argument', () async {
      final commandName = "commandName";
      final fakeCommand = FakeCommand(
        name: commandName,
        description: "theDescription",
        arguments: [FakeArgument(name: "", description: "argDescription", output: "The content")],
        defaultArgument: "",
      );
      final command = FakeCommandWrapper(fakeCommand, (_) async => "");
      final argument = "myArgument";
      expect(
        await command.execute(arguments: [argument], history: []),
        [FakeCommandWrapper.argumentInvalid(commandName, argument)],
      );
    });

    test('given argument then execute it and return the remote content', () async {
      final argument = "myArgument";
      final outputContentUrl = "http://thecontentis.here";
      final fakeCommand = FakeCommand(
        name: "commandName",
        description: "theDescription",
        arguments: [FakeArgument(name: argument, description: "argDescription", outputUrl: outputContentUrl)],
        defaultArgument: argument,
      );
      int fetchUrlCounter = 0;
      final remoteContent = "This is the content";
      final command = FakeCommandWrapper(fakeCommand, (url) async {
        expect(url, outputContentUrl);
        fetchUrlCounter++;
        return remoteContent;
      });
      expect(await command.execute(arguments: [], history: []), [remoteContent]);
      expect(fetchUrlCounter, 1);
    });
  });

  group('execute', () {
    test('given argument a FakeArgument that does not exist then return null', () async {
      final argument = "myArgument";
      final fakeCommand = FakeCommand(
        name: "commandName",
        description: "theDescription",
        arguments: [FakeArgument(name: "", description: "argDescription", output: "defaultArgOutput")],
        defaultArgument: "",
      );
      final command = FakeCommandWrapper(fakeCommand, (_) async => "");
      expect(command.autocomplete(argument), null);
    });

    test('given argument half name of a FakeArgument that exist then return file name', () async {
      final argument = "myArgument";
      final fakeCommand = FakeCommand(
        name: "commandName",
        description: "theDescription",
        arguments: [FakeArgument(name: argument, description: "argDescription", output: "defaultArgOutput")],
        defaultArgument: argument,
      );
      final command = FakeCommandWrapper(fakeCommand, (_) async => "");
      expect(command.autocomplete("my"), argument);
    });
  });
}
