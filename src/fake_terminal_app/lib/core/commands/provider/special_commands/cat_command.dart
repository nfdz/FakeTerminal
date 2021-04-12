import 'package:fake_terminal_app/core/commands/local/fake_data.dart';
import 'package:fake_terminal_app/core/commands/model/terminal_command.dart';

class CatCommand extends TerminalCommand {
  final Map<FakeFile, String> fakeFiles;
  CatCommand(this.fakeFiles) : super(name: _kCommandName, manual: _kCommandManual);

  @override
  List<String> execute(List<String> arguments) {
    if (arguments.isEmpty) {
      return [_kCommandInvalid];
    }
    return arguments.map((argument) => _getCatFor(argument)).toList();
  }

  String _getCatFor(String argument) {
    final matches = fakeFiles.entries.where((entry) => entry.key.name == argument);
    if (matches.isNotEmpty) {
      final fileEntry = matches.first;
      return fileEntry.value;
    } else {
      return _getFileNotFoundOutput(argument);
    }
  }

  String _getFileNotFoundOutput(String file) {
    return "cat: $file: No such file or directory";
  }

  @override
  String? autocomplete(String argument) {
    final matches = fakeFiles.entries.where((entry) => entry.key.name == argument);
    if (matches.isNotEmpty) {
      final fileEntry = matches.first;
      return fileEntry.key.name;
    } else {
      return null;
    }
  }
}

const String _kCommandName = "cat";
const String _kCommandManual = """
CAT(1)

NAME
       cat - concatenate files and print on the standard output

SYNOPSIS
       cat [FILE]

DESCRIPTION
       Concatenate FILE(s) to standard output.

EXAMPLES
       cat ./my-file.txt
              Output content of 'about.json'.""";
const String _kCommandInvalid = "Input argument required, to learn about this command use: man cat";
