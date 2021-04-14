import 'package:fake_terminal_app/core/command_url/command_url_loader.dart';
import 'package:fake_terminal_app/core/commands/model/terminal_command.dart';
import 'package:fake_terminal_app/core/fake_data/model/fake_data.dart';

class CatCommand extends TerminalCommand {
  final List<FakeFile> _fakeFiles;
  final CommandUrlLoader _urlLoader;
  CatCommand(this._fakeFiles, this._urlLoader)
      : super(
          name: _kCommandName,
          description: _kCommandDescription,
          manual: _kCommandManual,
        );

  @override
  Future<List<String>> execute(List<String> arguments) async {
    if (arguments.isEmpty) {
      return [_kCommandInvalid];
    }
    final List<String> output = [];
    for (final argument in arguments) {
      output.add(await _getCatFor(argument));
    }
    return output;
  }

  Future<String> _getCatFor(String argument) async {
    final matches = _fakeFiles.where((file) => file.name == argument);
    if (matches.isNotEmpty) {
      final contentUrl = matches.first.contentUrl;
      return await _urlLoader.load(contentUrl);
    } else {
      return _getFileNotFoundOutput(argument);
    }
  }

  String _getFileNotFoundOutput(String file) {
    return "cat: $file: No such file or directory";
  }

  @override
  String? autocomplete(String argument) {
    final matches = _fakeFiles.where((file) => file.name == argument);
    if (matches.isNotEmpty) {
      return matches.first.name;
    } else {
      return null;
    }
  }
}

const String _kCommandName = "cat";
const String _kCommandDescription = "Concatenate FILE(s) to standard output";
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
