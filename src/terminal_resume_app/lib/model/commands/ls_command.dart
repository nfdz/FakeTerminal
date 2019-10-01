import 'package:terminal_resume_app/model/command.dart';
import 'package:terminal_resume_app/model/terminal_content.dart';
import 'package:terminal_resume_app/utils/constants.dart';

class LsCommand extends Command {
  static LsCommand _instance;

  factory LsCommand() {
    if (_instance == null) {
      _instance = LsCommand._();
    }
    return _instance;
  }

  LsCommand._() : super(kCmdLs, kCmdLsManEntry);

  @override
  void execute(List<String> args, List<TerminalLine> output) {
    if (args.length > 1) {
      output.insert(0, ResultLine(kCmdIgnoredArgs));
    }
    output.insert(0, ResultLine(kCmdLsOutput));
  }
}

const String kCmdLs = "ls";
const String kCmdLsOutput = """
drwxr-xr-x nfdz 2K nov about.json
drwxr-xr-x nfdz 4K sep education.json
drwxr-xr-x nfdz 7K dic objetives.json
drwxr-xr-x nfdz 8K nov skills.json
drwxr-xr-x nfdz 7K nov experience.json""";
const String kCmdLsManEntry = """
LS(1)

NAME
       ls - list directory contents

SYNOPSIS
       ls

DESCRIPTION
       List information about the FILEs (the current directory by default).

OPTIONS
       None.""";
