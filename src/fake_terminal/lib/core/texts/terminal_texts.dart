class TerminalTexts {
  static const String welcomeText = """
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  nfdz@github.io
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  --------------
MMm .oMMMMMMMN: sMMMM+----------/MM  OS: Manjaro Ornara 21.1
MMh   -dMMMMMN  /MMMN  `MMMMMMMMMMM  Kernel: x86_64 Linux 5.1
MMh  `  oMMMMN  /MMMN  .MMMMMMMMMMM  Uptime: 168h 16m
MMh  oy` .dMMN  /MMMN  `yyhhhhhNMMM  Packages: 2048
MMh  oMN+  +NN  /MMMN   .......-MMM  Shell: bash 5.1
MMh  oMMMd. .y  /MMMN  .MMMMMMMMMMM  WM: Compiz
MMh  oMMMMMo    /MMMN  .MMMMMMMMMMM  WM Theme: Numix
MMd  oMMMMMMm-  /MMMN  .MMMMMMMMMMM  CPU: Intel Core i7 CPU
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  GPU: Mesa DRI Intel HD
MMMMMMMMMNMMMMMMMMMMNMMMMMMMMMMMMMM  RAM: 5599MiB / 15700MiB
MMm  `++++/-  .sMMMMM--------.  /NM  --------------
MMm  .MMMMMMN+  :MMMMMMMMMMm- `yMMM
MMm  .MMMMMMMM:  yMMMMMMMMs` :mMMMM  Welcome!
MMm  .MMMMMMMMo  oMMMMMMN:  sMMMMMM  This shell contains a set
MMm  .MMMMMMMM-  hMMMMMh` -mMMMMMMM  of tools that will help
MMm  .MMMMMMd:  /MMMMN/  +MMMMMMMMM  you to know about me.
MMm  `::::-`  -yMMMMN.  .:::::::/dM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  Start with 'man nfdz'
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  and 'help'.
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