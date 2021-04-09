import 'package:flutter/material.dart';

const int kKeyCodeEnter = 54;
const int kKeyCodeUp = 106;
const int kKeyCodeDown = 108;
const int kKeyCodeTab = 50;

// Personalization
const Color kPrimaryColor = Color(0xFF242424);
const Color kLightPrimaryColor = Color(0xff424242);
const Color kAccentColor = Color(0xff1e90ff);
const Color kTerminalAccentColor = Color(0xff72d5a3);
const TextStyle kDefaultTextStyle = TextStyle(fontFamily: 'FiraCode', fontSize: 16, color: Colors.white);
const TextStyle kSmallerTextStyle = TextStyle(fontFamily: 'FiraCode', fontSize: 14, color: Colors.white);
const TextStyle kSmallestTextStyle = TextStyle(fontFamily: 'FiraCode', fontSize: 9, color: Colors.white);
const double kSmallerToBigWidth = 850.0;
const double kSmallestToSmallerWidth = 700.0;

// Texts (Command texts are located in each command data class)
const String kAppName = "Terminal - nfdz";
const String kCommandBoxHint = "Enter a command...";
const String kSendCommandTooltip = "Execute command";
const String kBackTooltip = "Exit terminal";
const String kWarningButton = "Warning! This is a Flutter experiment v1.10.6";
const String kWarningDialogTitle = "Flutter Web Experiment";
const String kWarningDialogContent =
    "Flutter web is currently in experimental state. The project progress is very fast and the roadmap looks amazing. This app is a test field to see how everything works, how is the performance and find bugs. I hope to be able to report something and contribute as much as I can to the project. You can take a look to the code in the repository, it is software libre GPLv3. Have fun!";
const String kWarningDialogGithub = "Github";
const String kTerminalPrefix = "[nfdz@github.io ~]\$ ";
const String kCmdNotFound = "bash: {cmd}: command not found";
const String kHelpArg = "-h";

const String kWelcomeText = """
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  nfdz@github.io
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  --------------
MMMm .oMMMMMMMN: sMMMM+----------/MMM  OS: Manjaro Juhraya 18.1.0
MMMh   -dMMMMMN  /MMMN  `MMMMMMMMMMMM  Kernel: x86_64 Linux 4.10.0-3
MMMh  `  oMMMMN  /MMMN  .MMMMMMMMMMMM  Uptime: 168h 16m
MMMh  oy` .dMMN  /MMMN  `yyhhhhhNMMMM  Packages: 2048
MMMh  oMN+  +NN  /MMMN   .......-MMMM  Shell: bash 4.4.7
MMMh  oMMMd. .y  /MMMN  .MMMMMMMMMMMM  WM: Compiz
MMMh  oMMMMMo    /MMMN  .MMMMMMMMMMMM  WM Theme: Numix
MMMd  oMMMMMMm-  /MMMN  .MMMMMMMMMMMM  CPU: Intel Core i7-7500U CPU
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  GPU: Mesa DRI Intel(R) HD 620
MMMMMMMMMMNMMMMMMMMMMNMMMMMMMMMMMMMMM  RAM: 3599MiB / 7850MiB
MMMm  `++++/-  .sMMMMM--------.  /NMM  --------------
MMMm  .MMMMMMN+  :MMMMMMMMMMm- `yMMMM
MMMm  .MMMMMMMM:  yMMMMMMMMs` :mMMMMM  Welcome!
MMMm  .MMMMMMMMo  oMMMMMMN:  sMMMMMMM  You will have access to a few
MMMm  .MMMMMMMM-  hMMMMMh` -mMMMMMMMM  programs and files so you 
MMMm  .MMMMMMd:  /MMMMN/  +MMMMMMMMMM  can know about me easly.
MMMm  `::::-`  -yMMMMN.  .:::::::/dMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  Start the fun with 'man nfdz'
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  For global help type 'help'.
""";
const String kCmdIgnoredArgs = "(Some input arguments were ignored)";
const String kCmdInvalidArgs = "Input argument required, to learn about this command use: man ";
const String kCmdInvalidArg = "Invalid argument, to learn about this command use: man ";
