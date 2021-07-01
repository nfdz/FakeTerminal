import 'package:fake_terminal/terminal/models/terminal_command.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';

class GitHubCommand extends TerminalCommand {
  final Function _onOpenTerminalRepository;
  final Function _onOpenPersonalRepository;
  GitHubCommand(this._onOpenTerminalRepository, this._onOpenPersonalRepository)
      : super(
          name: _kCommandName,
          description: _kCommandDescription,
          manual: _kCommandManual,
        );

  @override
  Future<List<String>> execute({required List<String> arguments, required List<String> history}) async {
    if (arguments.isEmpty) {
      return [_kCommandInvalid];
    }
    return arguments.map((argument) => _openRepositoryOf(argument)).toList();
  }

  String _openRepositoryOf(String argument) {
    switch (argument) {
      case _kTerminalArgument:
        _onOpenTerminalRepository();
        return _kOpenedRepo;
      case TerminalTexts.personalRepositoryName:
        _onOpenPersonalRepository();
        return _kOpenedRepo;
      default:
        return _kNotFoundOutputFor + argument;
    }
  }

  String? autocomplete(String argument) {
    if (_kTerminalArgument.startsWith(argument)) {
      return _kTerminalArgument;
    } else if (TerminalTexts.personalRepositoryName.startsWith(argument)) {
      return TerminalTexts.personalRepositoryName;
    } else {
      return null;
    }
  }
}

const String _kCommandName = "github";
const String _kCommandDescription = "Open the repository";
const String _kCommandManual = """
EXIT(1)

NAME
       github - open a repository

SYNOPSIS
       github [REPOSITORY]

DESCRIPTION
       Open REPOSITORY(s) in the browser.

OPTIONS
       github $_kTerminalArgument
       github ${TerminalTexts.personalRepositoryName}""";
const String _kTerminalArgument = "terminal";
const String _kCommandInvalid = "Input argument required, to learn about this command use: man github";
const String _kNotFoundOutputFor = "No repository for ";
const String _kOpenedRepo = "The repository was opened...";
