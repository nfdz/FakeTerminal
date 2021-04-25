import 'package:fake_terminal/terminal/models/commands/commands.dart';
import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';
import 'package:fake_terminal/terminal/repositories/fake_data_repository/fake_data_repository.dart';
import 'package:fake_terminal/terminal/repositories/url_repository/url_repository.dart';
import 'package:riverpod/riverpod.dart';

final commandsRepositoryProvider = Provider<CommandsRepository>((ref) {
  final fakeDataRepository = ref.read(fakeDataRepositoryProvider);
  final urlRepository = ref.read(urlRepositoryProvider);
  return _CommandsRepositoryFakeData(fakeDataRepository, urlRepository);
});

abstract class CommandsRepository {
  Future<List<TerminalCommand>> load({
    required List<String> Function() getHistory,
    required Function? onExitTerminal,
  });
}

class _CommandsRepositoryFakeData extends CommandsRepository {
  final FakeDataRepository _fakeDataRepository;
  final UrlRepository _urlRepository;
  _CommandsRepositoryFakeData(this._fakeDataRepository, this._urlRepository);

  @override
  Future<List<TerminalCommand>> load({
    required List<String> Function() getHistory,
    required Function? onExitTerminal,
  }) async {
    FakeData fakeData = await _fakeDataRepository.load();
    List<TerminalCommand> commands = [];
    commands.add(CatCommand(fakeData.fakeFiles, (String url) => _urlRepository.load(url)));
    commands.add(ClearCommand());
    if (onExitTerminal != null) {
      commands.add(ExitCommand(onExitTerminal));
    }
    commands.add(HelpCommand(() => commands));
    commands.add(HistoryCommand(getHistory));
    commands.add(LsCommand(fakeData.fakeFiles));
    commands.add(ManCommand(() => commands));
    //fakeData.fakeCommands
    //
    return commands;
  }
}
