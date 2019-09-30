import 'package:flutter/material.dart';

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

// Texts
const String kAppName = 'Terminal - nfdz';
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

const String kCmdHelp = "help";
const String kCmdHelpOutput = """
The commands that are enabled are the following:
 cat     - Concatenate FILE(s) to standard output
 clear   - Clear the terminal screen
 exit    - Log off and close the app
 flutter - Flutter app development
 help    - Show help information about terminal
 ls      - List directory contents
 man     - An interface to the on-line reference manuals
 nfdz    - Processes the json files with information about me""";
const String kCmdHelpManEntry = """
HELP(1)

NAME
       help - Print help for working enviroment.

SYNOPSIS
       help

DESCRIPTION
       List information about the work options of current working enviroment.

OPTIONS
       None.""";

const String kCmdLs = "ls";
const String kCmdLsOutput = """
drwxr-xr-x nfdz 2K nov about_me.json
drwxr-xr-x nfdz 4K sep education.json
drwxr-xr-x nfdz 7K dic professional_objetives.json
drwxr-xr-x nfdz 8K nov professional_skills.json
drwxr-xr-x nfdz 7K nov work_experience.json""";
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

const String kCmdClear = "clear";
const String kCmdClearManEntry = """
CLEAR(1)

NAME
       clear - clear the terminal screen

SYNOPSIS
       clear

DESCRIPTION
       clear clears your screen if this is possible, including its scrollback buffer.

HISTORY
       A clear command appeared in 2.79BSD dated February 24, 1979. Later that was provided in Unix 8th edition (1985).

OPTIONS
       None.""";

const String kCmdMan = "man";
const String kCmdManNotFound = "No manual entry for ";
const String kCmdManManEntry = """
MAN(1)

NAME
       man - an interface to the on-line reference manuals

SYNOPSIS
       man [CMD]

DESCRIPTION
       man is the system's manual pager.  Each page argument given to man is normally the name of a program, utility or function. The manual page associated with each of these arguments is then found and displayed.

EXAMPLES
       man ls
           Display the manual page for the item (program) ls.

DEFAULTS
       man will search for the desired manual pages within the index database caches.""";

const String kCmdCat = "cat";
const String kCmdCatManEntry = """
CAT(1)

NAME
       cat - concatenate files and print on the standard output

SYNOPSIS
       cat [FILE]

DESCRIPTION
       Concatenate FILE(s) to standard output.

EXAMPLES
       cat ./about_me.json
              Output content of 'about_me.json'.""";

const String kCmdExit = "exit";
const String kCmdExitManEntry = """
EXIT(1)

NAME
       exit - cause the shell to exit

SYNOPSIS
       exit

DESCRIPTION
       The exit utility shall cause the shell to exit with the exit status specified by the unsigned decimal integer n.  If n is specified, but its value is not between 0 and 255 inclusively, the exit status is undefined.

OPTIONS
       None.""";

const String kCmdFlutter = "flutter";
const String kCmdFlutterManEntry = """
FLUTTER(1)

NAME
       flutter - Manage your Flutter app development.

SYNOPSIS
       flutter [OPTION]

OPTIONS
       channel - List or switch flutter channels.
       doctor  - Show information about the installed tooling.
       version - List or switch flutter versions.""";

const String kCmdNfdz = "nfdz";
const String kCmdNfdzManEntry = """
NFDZ(1)

NAME
       nfdz - Processes the json files with information about me.

SYNOPSIS
       nfdz [OPTION]

OPTIONS
       about      - Know about me.
       education  - Know about my education.
       experience - Know about my work experience.
       hello      - Not greeting is unpolite.
       objectives - Know about my professional goals.
       skills     - Know about my professional skills.
       version    - the current operational version.""";
