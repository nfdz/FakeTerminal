import 'package:fake_terminal/core/terminal/model/terminal_line.dart';
import 'package:fake_terminal/core/terminal/model/terminal_state.dart';
import 'package:fake_terminal/core/texts/terminal_texts.dart';

// final Logger _kLogger = Logger("ThemeSystem");

TerminalState getDefaultTerminalFromSystem() {
  // TODO UA
  return TerminalState(
    historyInput: [],
    output: [
      TerminalLine(line: TerminalTexts.welcomeText, type: LineType.result),
    ],
  );
}
