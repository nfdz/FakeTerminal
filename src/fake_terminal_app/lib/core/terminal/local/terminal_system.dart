import 'package:fake_terminal_app/core/terminal/model/terminal_history.dart';
import 'package:fake_terminal_app/core/terminal/model/terminal_line.dart';
import 'package:fake_terminal_app/utils/constants.dart';

// final Logger _kLogger = Logger("ThemeSystem");

TerminalHistory getDefaultTerminalFromSystem() {
  // TODO UA
  return TerminalHistory(output: [
    TerminalLine(line: kWelcomeText, type: LineType.result),
    TerminalLine(line: "\n\n\n\n", type: LineType.result),
  ]);
}
