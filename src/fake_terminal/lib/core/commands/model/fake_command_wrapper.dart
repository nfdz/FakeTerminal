import 'package:fake_terminal/core/commands/model/terminal_command.dart';
import 'package:fake_terminal/core/fake_data/model/fake_data.dart';
import 'package:fake_terminal/core/command_url/command_url_loader.dart';

class FakeCommandWrapper extends TerminalCommand {
  final FakeCommand _fakeCommand;
  final CommandUrlLoader _urlLoader;
  FakeCommandWrapper(this._fakeCommand)
      : super(
          name: _fakeCommand.name,
          description: _fakeCommand.description,
          manual: _buildManual(_fakeCommand),
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
    final matches = _fakeFiles.where((file) => file.name.startsWith(argument));
    if (matches.isNotEmpty) {
      return matches.first.name;
    } else {
      return null;
    }
  }
}

String _buildManual(FakeCommand fakeCommand) {
  final commandsManual = fakeCommand.arguments
      .fold("", (previousValue, element) => "$previousValue\n       ${element.name}       ${element.description}");
  return """
${fakeCommand.name.toUpperCase()}(1)

NAME
       ${fakeCommand.name.toLowerCase()} - ${fakeCommand.description.toLowerCase()}

DESCRIPTION
       The options are as follows:
       $commandsManual
""";
}

const String _kCommandInvalid = "Input argument required, to learn about this command use: man cat";
