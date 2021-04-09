import 'package:logging/logging.dart';
import 'package:fake_terminal_app/model/command.dart';
import 'package:fake_terminal_app/model/commands/man_command.dart';
import 'package:fake_terminal_app/model/terminal_content.dart';
import 'package:fake_terminal_app/utils/constants.dart';

final Logger _kLogger = Logger("TerminalExecutor");

class TerminalBrain {
  final List<TerminalLine> _content = getTerminalInitContent();
  final List<String> _history = [];
  int _historyPointer = -1;

  int get contentCount => _content.length;

  TerminalLine entryAt(int index) => _content[index];

  void executeCommand(String cmd) {
    _kLogger.info("Executing command: $cmd");
    _writeCommandLine(cmd);
    _historyPointer = -1;
    if (cmd.isNotEmpty) {
      _history.add(cmd);
      final cmdArray = cmd.split(" ");
      var commandText = cmdArray.first;
      Command? command = parseCommand(commandText);
      if (command != null) {
        // Force man command if user type '-h' arg after any command
        if (cmdArray.length > 1 && cmdArray[1] == kHelpArg) {
          command = ManCommand();
        }
        command.execute(cmdArray, _content, _history);
      } else {
        _writeUnknownCommand(commandText);
      }
    }
  }

  void _writeCommandLine(String cmd) => _content.insert(0, CommandLine(cmd));
  void _writeUnknownCommand(String command) => _content.insert(
      0, ResultLine(kCmdNotFound.replaceFirst("{cmd}", command)));

  String? getHistoryUp() {
    _kLogger.fine("getHistoryUp(_historyPointer:$_historyPointer)");
    if (_history.length > 0) {
      if (_historyPointer < 0) {
        _historyPointer = _history.length;
      }
      if (_historyPointer >= 0) {
        if (_historyPointer > 0) {
          _historyPointer--;
        }
        return _history[_historyPointer];
      }
    }
    return null;
  }

  String? getHistoryDown() {
    _kLogger.fine("getHistoryDown(_historyPointer:$_historyPointer)");
    if (_history.length > 0) {
      if (_historyPointer < 0) {
        return null;
      }
      if (_historyPointer >= _history.length - 1) {
        return "";
      } else {
        _historyPointer++;
        return _history[_historyPointer];
      }
    }
    return null;
  }
}
