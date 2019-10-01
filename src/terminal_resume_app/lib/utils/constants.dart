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
const TextStyle kSmallestTextStyle = TextStyle(fontFamily: 'FiraCode', fontSize: 10, color: Colors.white);
const double kSmallerToBigWidth = 850.0;
const double kSmallestToSmallerWidth = 700.0;

// Texts (Command texts are located in each command data class)
const String kAppName = "Terminal - nfdz";
const String kCommandBoxHint = "Enter a command...";
const String kSendCommandTooltip = "Execute command";
const String kBackTooltip = "Exit terminal";
const String kWarningButton = "Warning! This is a Flutter experiment v1.10.6";
const String kWarningDialogTitle = "TODO";
const String kWarningDialogContent = "TODO";
const String kTerminalPrefix = "[nfdz@github.io ~]\$ ";
const String kCmdNotFound = "bash: {cmd}: command not found";
const String kHelpArg = "-h";

const String kWelcomeText = """
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    nfdz@github.io
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    --------------
MMMMm .oMMMMMMMN: sMMMM+----------/MMMMM    OS: Manjaro Juhraya 18.1.0
MMMMh   -dMMMMMN  /MMMN  `MMMMMMMMMMMMMM    Kernel: x86_64 Linux 4.10.0-30
MMMMh  `  oMMMMN  /MMMN  .MMMMMMMMMMMMMM    Uptime: 168h 16m
MMMMh  oy` .dMMN  /MMMN  `yyhhhhhNMMMMMM    Packages: 2048
MMMMh  oMN+  +NN  /MMMN   .......-MMMMMM    Shell: bash 4.4.7
MMMMh  oMMMd. .y  /MMMN  .MMMMMMMMMMMMMM    WM: Compiz
MMMMh  oMMMMMo    /MMMN  .MMMMMMMMMMMMMM    WM Theme: Numix
MMMMd  oMMMMMMm-  /MMMN  .MMMMMMMMMMMMMM    CPU: Intel Core i7-7500U CPU
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    GPU: Mesa DRI Intel(R) HD 620
MMMMMMMMMMMNMMMMMMMMMMNMMMMMMMMMMMMMMMMM    RAM: 3599MiB / 7850MiB
MMMMm  `++++/-  .sMMMMM--------.  /NMMMM    --------------
MMMMm  .MMMMMMN+  :MMMMMMMMMMm- `yMMMMMM
MMMMm  .MMMMMMMM:  yMMMMMMMMs` :mMMMMMMM    Welcome!
MMMMm  .MMMMMMMMo  oMMMMMMN:  sMMMMMMMMM    You will have access to a few
MMMMm  .MMMMMMMM-  hMMMMMh` -mMMMMMMMMMM    programs and files so you 
MMMMm  .MMMMMMd:  /MMMMN/  +MMMMMMMMMMMM    can know about me easly.
MMMMm  `::::-`  -yMMMMN.  .:::::::/dMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    Start with a hello 'nfdz hello'
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    If you need help execute 'help'.
""";
const String kCmdIgnoredArgs = "(Some input arguments were ignored)";
const String kCmdInvalidArgs = "Input argument required, to learn about this command use: man ";
const String kCmdInvalidArg = "Invalid argument, to learn about this command use: man ";
