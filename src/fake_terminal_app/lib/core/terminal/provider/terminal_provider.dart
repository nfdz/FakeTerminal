import 'package:fake_terminal_app/core/terminal/local/terminal_persistence.dart';
import 'package:fake_terminal_app/core/terminal/local/terminal_system.dart';
import 'package:fake_terminal_app/core/terminal/model/terminal_history.dart';
import 'package:fake_terminal_app/core/terminal/model/terminal_line.dart';
import 'package:fake_terminal_app/core/theme/model/theme_settings.dart';
import 'package:fake_terminal_app/utils/constants.dart';
import 'package:riverpod/riverpod.dart';

final terminalProvider = StateNotifierProvider<TerminalNotifier, TerminalHistory>((ref) {
  return TerminalNotifier(TerminalPersistencePreferences());
});

class TerminalNotifier extends StateNotifier<TerminalHistory> {
  final TerminalPersistence _persistence;

  TerminalNotifier(this._persistence) : super(getDefaultTerminalFromSystem()) {
    _initState();
  }

  void _initState() async {
    state = await _persistence.fetchTerminalHistory();
  }

  List<TerminalLine> get output {
    return state.output;
  }

  int? get historyTimestamp {
    return state.timestamp;
  }

  String get terminalInputPrefix {
    return kTerminalPrefix;
  }

  String get terminalInputHint {
    return kCommandBoxHint;
  }

  String get executeCommandTooltip {
    return kSendCommandTooltip;
  }

  void executeCommand(String commandLine) {}
}
