import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands/exit_command.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands/fake_command_wrapper.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands/js_command.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/exit_executor.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_loader.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/javascript_executor.dart';
import 'package:fake_terminal/terminal/repositories/content_repository/content_repository.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/fake_data_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'commands_loader_test.mocks.dart';

@GenerateMocks([FakeDataRepository, ContentRepository, ExitExecutor, JavascriptExecutor])
void main() {
  group('loadCommands', () {
    test('invoke fakeDataRepository.load once', () async {
      final fakeDataRepository = MockFakeDataRepository();
      final contentRepository = MockContentRepository();
      when(fakeDataRepository.load()).thenAnswer((_) async => FakeData(fakeCommands: [], fakeFiles: []));
      final exitExecutor = MockExitExecutor();
      when(exitExecutor.executeExitCommand()).thenReturn(null);
      when(exitExecutor.hasExitCommand()).thenReturn(false);

      final commandsLoader = CommandsLoaderImpl(fakeDataRepository, contentRepository, exitExecutor, null);
      await commandsLoader.loadCommands();

      verify(fakeDataRepository.load()).called(1);
    });

    test('given JavascriptExecutor is present then returns JsCommand', () async {
      final fakeDataRepository = MockFakeDataRepository();
      final contentRepository = MockContentRepository();
      when(fakeDataRepository.load()).thenAnswer((_) async => FakeData(fakeCommands: [], fakeFiles: []));
      final exitExecutor = MockExitExecutor();
      when(exitExecutor.executeExitCommand()).thenReturn(null);
      when(exitExecutor.hasExitCommand()).thenReturn(false);
      final javascriptExecutor = MockJavascriptExecutor();

      final commandsLoader =
          CommandsLoaderImpl(fakeDataRepository, contentRepository, exitExecutor, javascriptExecutor);
      final commands = await commandsLoader.loadCommands();

      expect(commands.where((element) => element is JsCommand).length, 1);
    });

    test('given ExitExecutor.hasExitCommand is true then returns ExitCommand', () async {
      final fakeDataRepository = MockFakeDataRepository();
      final contentRepository = MockContentRepository();
      when(fakeDataRepository.load()).thenAnswer((_) async => FakeData(fakeCommands: [], fakeFiles: []));
      final exitExecutor = MockExitExecutor();
      when(exitExecutor.executeExitCommand()).thenReturn(null);
      when(exitExecutor.hasExitCommand()).thenReturn(true);

      final commandsLoader = CommandsLoaderImpl(fakeDataRepository, contentRepository, exitExecutor, null);
      final commands = await commandsLoader.loadCommands();

      expect(commands.where((element) => element is ExitCommand).length, 1);
    });

    test('given one fake command then returns one FakeCommandWrapper', () async {
      final fakeDataRepository = MockFakeDataRepository();
      final contentRepository = MockContentRepository();
      final fakeCommandName = "TestFakeCommand";
      when(fakeDataRepository.load()).thenAnswer((_) async => FakeData(
            fakeCommands: [
              FakeCommand(
                name: fakeCommandName,
                description: "test description",
                arguments: [FakeArgument(name: "myArg", description: "arg description", output: "arg output")],
                defaultArgument: "myArg",
              )
            ],
            fakeFiles: [],
          ));
      final exitExecutor = MockExitExecutor();
      when(exitExecutor.executeExitCommand()).thenReturn(null);
      when(exitExecutor.hasExitCommand()).thenReturn(false);

      final commandsLoader = CommandsLoaderImpl(fakeDataRepository, contentRepository, exitExecutor, null);
      final commands = await commandsLoader.loadCommands();

      final fakeCommands = commands.where((element) => element is FakeCommandWrapper);
      expect(fakeCommands.length, 1);
      expect(fakeCommands.first.name, fakeCommandName);
    });
  });
}
