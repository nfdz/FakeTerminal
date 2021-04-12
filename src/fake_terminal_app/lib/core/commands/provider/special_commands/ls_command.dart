import 'package:fake_terminal_app/core/commands/local/fake_data.dart';
import 'package:fake_terminal_app/core/commands/model/terminal_command.dart';

class LsCommand extends TerminalCommand {
  final Map<FakeFile, String> fakeFiles;
  final String currentMonth = _kMonthsOfTheYear[DateTime.now().month - 1];
  LsCommand(this.fakeFiles) : super(name: _kCommandName, manual: _kCommandManual);

  @override
  List<String> execute(List<String> arguments) {
    return fakeFiles.entries.map((fileEntry) => _mapFile(fileEntry)).toList();
  }

  String _mapFile(MapEntry<FakeFile, String> fileEntry) {
    final fileSize = fileEntry.value.length.toString().substring(0, 1);
    return "$_kPermission $_kUser ${fileSize}K $currentMonth ${fileEntry.key.name}";
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
const List<String> _kMonthsOfTheYear = [
  "jan",
  "feb",
  "mar",
  "apr",
  "may",
  "jun",
  "jul",
  "aug",
  "sep​",
  "oct",
  "nov",
  "dec"
];
