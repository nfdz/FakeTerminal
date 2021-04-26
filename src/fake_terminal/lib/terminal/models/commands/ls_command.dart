import 'package:fake_terminal/terminal/models/fake_data.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';

class LsCommand extends TerminalCommand {
  final List<FakeFile> _fakeFiles;
  final String _currentMonth = TerminalTexts.getCurrentMonthText();
  LsCommand(this._fakeFiles)
      : super(
          name: _kCommandName,
          description: _kCommandDescription,
          manual: _kCommandManual,
        );

  @override
  Future<List<String>> execute({required List<String> arguments, required List<String> history}) async {
    return _fakeFiles.map((file) => _mapFile(file)).toList();
  }

  String _mapFile(FakeFile file) {
    final fileSize = String.fromCharCode(file.name.length.toString().runes.last);
    return "$_kPermission $_kUser ${fileSize}K $_currentMonth ${file.name}";
  }

  @override
  String? autocomplete(String argument) {
    return null;
  }
}

const String kCmdLsOutput = """
drwxr-xr-x nfdz 2K nov about.json
drwxr-xr-x nfdz 4K sep education.json
drwxr-xr-x nfdz 7K dic objetives.json
drwxr-xr-x nfdz 8K nov skills.json
drwxr-xr-x nfdz 7K nov experience.json""";

const String _kCommandName = "ls";
const String _kCommandDescription = "List directory contents";
const String _kCommandManual = """
LS(1)

NAME
       ls - list directory contents

SYNOPSIS
       ls

DESCRIPTION
       List information about the FILEs (the current directory by default).

OPTIONS
       None.""";

const String _kPermission = "drwxr-xr-x";
const String _kUser = "admin";
