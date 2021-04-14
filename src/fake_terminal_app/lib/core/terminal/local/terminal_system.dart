import 'package:fake_terminal_app/core/terminal/model/terminal_line.dart';
import 'package:fake_terminal_app/core/terminal/model/terminal_state.dart';
import 'package:fake_terminal_app/utils/constants.dart';

// final Logger _kLogger = Logger("ThemeSystem");

TerminalState getDefaultTerminalFromSystem() {
  // TODO UA
  return TerminalState(
    historyInput: [],
    output: [
      TerminalLine(line: kWelcomeText, type: LineType.result),
    ],
  );
}
