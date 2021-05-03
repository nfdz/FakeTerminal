import 'package:fake_terminal/terminal/models/terminal_state.dart';
import 'package:fake_terminal/terminal/providers/terminal_provider_impl.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_repository.dart';
import 'package:fake_terminal/terminal/repositories/history_repository/persistence_repository.dart';
import 'package:riverpod/riverpod.dart';

final terminalProvider = StateNotifierProvider<TerminalNotifier, TerminalState>((ref) {
  final historyRepository = ref.read(historyRepositoryProvider);
  final commandsRepository = ref.read(commandsRepositoryProvider);
  return TerminalNotifierImpl(historyRepository, commandsRepository);
});

abstract class TerminalNotifier extends StateNotifier<TerminalState> {
  TerminalNotifier(TerminalState state) : super(state);

  bool canExitTerminal();
  void exitTerminal();
  void executeCommand(String commandLine);
  String? autocomplete(String commandLine);
  String? navigateHistoryBack(String commandLine);
  String? navigateHistoryForward(String commandLine);
}
