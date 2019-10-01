import 'package:logging/logging.dart';
import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/commands/man_command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';
import 'package:terminal_resume_app/utils/constants.dart';

final Logger _kLogger = Logger("TerminalExecutor");

class TerminalBrain {
  final List<TerminalLine> _content = getTerminalInitContent();

  int get contentCount => _content.length;

  TerminalLine entryAt(int index) => _content[index];

  void executeCommand(String cmd) {
    _kLogger.info("Executing command: $cmd");
    _writeCommandLine(cmd);
    if (cmd.isNotEmpty) {
      final cmdArray = cmd.split(" ");
      var commandText = cmdArray.first;
      Command command = parseCommand(commandText);
      if (command != null) {
        // Force man command if user type '-h' arg after any command
        if (cmdArray.length > 1 && cmdArray[1] == kHelpArg) {
          command = ManCommand();
        }
        command.execute(cmdArray, _content);
      } else {
        _writeUnknownCommand(commandText);
      }
    }
  }

  void _writeCommandLine(String cmd) => _content.insert(0, CommandLine(cmd));
  void _writeUnknownCommand(String command) =>
      _content.insert(0, ResultLine(kCmdNotFound.replaceFirst("{cmd}", command)));
}
