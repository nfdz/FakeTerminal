import 'package:terminal_resume_app/utils/constants.dart';

List<TerminalLine> getTerminalInitContent() => [
      ResultLine(kWelcomeText),
      ResultLine("\n\n\n"),
    ];

class TerminalLine {
  final String line;
  TerminalLine(this.line);
}

class CommandLine extends TerminalLine {
  CommandLine(String line) : super(line);
}

class ResultLine extends TerminalLine {
  ResultLine(String line) : super(line);
}
