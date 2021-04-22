class TerminalTexts {
  static const String welcomeText = """
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  nfdz@github.io
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  --------------
MMMm .oMMMMMMMN: sMMMM+----------/MMM  OS: Manjaro Ornara 21.1.0
MMMh   -dMMMMMN  /MMMN  `MMMMMMMMMMMM  Kernel: x86_64 Linux 5.12
MMMh  `  oMMMMN  /MMMN  .MMMMMMMMMMMM  Uptime: 168h 16m
MMMh  oy` .dMMN  /MMMN  `yyhhhhhNMMMM  Packages: 2048
MMMh  oMN+  +NN  /MMMN   .......-MMMM  Shell: bash 5.1
MMMh  oMMMd. .y  /MMMN  .MMMMMMMMMMMM  WM: Compiz
MMMh  oMMMMMo    /MMMN  .MMMMMMMMMMMM  WM Theme: Numix
MMMd  oMMMMMMm-  /MMMN  .MMMMMMMMMMMM  CPU: Intel Core i7-7500U CPU
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  GPU: Mesa DRI Intel(R) HD 620
MMMMMMMMMMNMMMMMMMMMMNMMMMMMMMMMMMMMM  RAM: 5599MiB / 15700MiB
MMMm  `++++/-  .sMMMMM--------.  /NMM  --------------
MMMm  .MMMMMMN+  :MMMMMMMMMMm- `yMMMM
MMMm  .MMMMMMMM:  yMMMMMMMMs` :mMMMMM  Welcome!
MMMm  .MMMMMMMMo  oMMMMMMN:  sMMMMMMM  This shell contains a set of
MMMm  .MMMMMMMM-  hMMMMMh` -mMMMMMMMM  command line tools that will
MMMm  .MMMMMMd:  /MMMMN/  +MMMMMMMMMM  help you to know about me.
MMMm  `::::-`  -yMMMMN.  .:::::::/dMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  Start the fun with 'man nfdz'
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  For more help type 'help'.
""";
  static const String appName = "Terminal - nfdz";
  static const String terminalInputPrefix = "[nfdz@github.io ~]\$ ";
  static const String terminalInputHint = "Enter a command...";
  static const String executeCommandTooltip = "Execute command";
  static const String exitTooltip = "Exit terminal";
  static const String infoTooltip = "More information";
  static const String toggleThemeTooltip = "Toggle theme";

  static String lastLoginMessage(int timestampMillis) {
    final time = DateTime.fromMillisecondsSinceEpoch(timestampMillis);
    final day = _kDaysOfTheWeek[time.weekday - 1];
    final month = _kMonthsOfTheYear[time.month - 1];
    return "Last login: $day $month ${time.day} ${time.hour}:${time.minute}:${time.second} on ttys000";
  }

  static String getCurrentMonthText() => _kMonthsOfTheYear[DateTime.now().month - 1];
}

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
  "dec",
];

const List<String> _kDaysOfTheWeek = [
  "mon",
  "tue",
  "wed",
  "thu",
  "fri",
  "sat",
  "sun",
];
