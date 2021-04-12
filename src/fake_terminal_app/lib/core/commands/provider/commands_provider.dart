import 'package:fake_terminal_app/core/commands/local/command_loader.dart';
import 'package:fake_terminal_app/core/terminal/local/terminal_persistence.dart';
import 'package:fake_terminal_app/core/terminal/local/terminal_system.dart';
import 'package:fake_terminal_app/core/terminal/model/terminal_history.dart';
import 'package:fake_terminal_app/core/terminal/model/terminal_line.dart';
import 'package:fake_terminal_app/utils/constants.dart';
import 'package:riverpod/riverpod.dart';

final commandsProvider = StateNotifierProvider<CommandsNotifier, List<TerminalCommands>>((ref) {
  return CommandsNotifier(CommandsLoaderAssets());
});

class CommandsNotifier extends StateNotifier<List<TerminalCommands>> {
  final CommandsLoader _commandsLoader;

  CommandsNotifier(this._persistence) : super(getDefaultTerminalFromSystem()) {
    _initState();
  }

  void _initState() async {
    state = await _persistence.fetchTerminalHistory();
  }

  List<TerminalLine> get output {
    return state.output;
  }
}
