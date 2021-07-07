import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';

class FakeCommandWrapper extends TerminalCommand {
  final FakeCommand _fakeCommand;
  final Future<String> Function(String url) _getUrlContent;
  FakeCommandWrapper(this._fakeCommand, this._getUrlContent)
      : super(
          name: _fakeCommand.name,
          description: _fakeCommand.description,
          manual: _buildManual(_fakeCommand),
        );

  @override
  Future<List<String>> execute({required List<String> arguments, required List<String> history}) async {
    if (arguments.isEmpty) {
      arguments = [_fakeCommand.defaultArgument];
    }

    final List<String> output = [];
    for (final argument in arguments) {
      final matches = _fakeCommand.arguments.where((fakeArgument) => fakeArgument.name == argument);
      if (matches.isNotEmpty) {
        final fakeArgument = matches.first;
        output.add(await _getOutputFor(fakeArgument.outputUrl, fakeArgument.output));
      } else {
        output.add(argumentInvalid(_fakeCommand.name, argument));
      }
    }
    return output;
  }

  Future<String> _getOutputFor(String? outputUrl, String? output) async {
    if (output?.isNotEmpty == true) {
      return output!;
    } else if (outputUrl?.isNotEmpty == true) {
      return await _getUrlContent(outputUrl!);
    } else {
      return "";
    }
  }

  @override
  String? autocomplete(String argument) {
    final matches = _fakeCommand.arguments.where((fakeArgument) => fakeArgument.name.startsWith(argument));
    if (matches.isNotEmpty) {
      return matches.first.name;
    } else {
      return null;
    }
  }

  static String argumentInvalid(String commandName, String argument) =>
      "Invalid argument '$argument', to learn about this command use: man $commandName";
}

String _buildManual(FakeCommand fakeCommand) {
  final commandsManual = fakeCommand.arguments
      .fold("", (previousValue, element) => "$previousValue\n       ${element.name} - ${element.description}");
  return """
${fakeCommand.name.toUpperCase()}(1)

NAME
       ${fakeCommand.name.toLowerCase()} - ${fakeCommand.description.toLowerCase()}

DESCRIPTION
       The options are as follows:
       $commandsManual
""";
}
