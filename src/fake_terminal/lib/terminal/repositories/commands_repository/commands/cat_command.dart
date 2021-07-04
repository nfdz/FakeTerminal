import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';

class CatCommand extends TerminalCommand {
  final List<FakeFile> _fakeFiles;
  final Future<String> Function(String url) _getUrlContent;
  CatCommand(this._fakeFiles, this._getUrlContent)
      : super(
          name: commandName,
          description: commandDescription,
          manual: commandManual,
        );

  @override
  Future<List<String>> execute({required List<String> arguments, required List<String> history}) async {
    if (arguments.isEmpty) {
      return [commandInvalid];
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
      final file = matches.first;
      if (file.content?.isNotEmpty == true) {
        return file.content!;
      } else if (file.contentUrl?.isNotEmpty == true) {
        return await _getUrlContent(file.contentUrl!);
      } else {
        return "";
      }
    } else {
      return fileNotFoundOutput(argument);
    }
  }

  @override
  String? autocomplete(String argument) {
    final matches = _fakeFiles.where((file) => file.name.startsWith(argument));
    if (matches.isNotEmpty) {
      return matches.first.name;
    } else {
      return null;
    }
  }

  static const String commandName = "cat";
  static const String commandDescription = "Concatenate FILE(s) to standard output";
  static const String commandManual = """
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
  static const String commandInvalid = "Input argument required, to learn about this command use: man cat";

  static String fileNotFoundOutput(String file) {
    return "cat: $file: No such file or directory";
  }
}
