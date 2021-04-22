// class FlutterCommand extends Command {
//   static FlutterCommand? _instance;

//   factory FlutterCommand() {
//     if (_instance == null) {
//       _instance = FlutterCommand._();
//     }
//     return _instance!;
//   }

//   FlutterCommand._() : super(kCmdFlutter, kCmdFlutterManEntry);

//   @override
//   void execute(
//       List<String> args, List<TerminalLine> output, List<String> history) {
//     if (args.length < 2) {
//       output.insert(0, ResultLine(kCmdInvalidArgs + cmd));
//     } else {
//       if (args.length > 2) {
//         output.insert(0, ResultLine(kCmdIgnoredArgs));
//       }
//       String arg = args[1];
//       switch (arg) {
//         case kCmdFlutterChannelArg:
//           output.insert(0, ResultLine(kCmdFlutterChannelArgOutput));
//           break;
//         case kCmdFlutterDoctorArg:
//           output.insert(0, ResultLine(kCmdFlutterDoctorArgOutput));
//           break;
//         case kCmdFlutterVersionArg:
//           output.insert(0, ResultLine(kCmdFlutterVersionArgOutput));
//           break;
//         default:
//           output.insert(0, ResultLine(kCmdInvalidArg + cmd));
//       }
//     }
//   }
// }

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
       version - List flutter versions.""";
const String kCmdFlutterChannelArg = "channel";
const String kCmdFlutterChannelArgOutput = """
Flutter channels:
  beta
* dev
  master
  stable""";
const String kCmdFlutterDoctorArg = "doctor";
const String kCmdFlutterDoctorArgOutput = """
Doctor summary:
[✓] Flutter (Channel dev, v1.10.6, on Linux, locale en_US.UTF-8)
 
[✓] Android toolchain - develop for Android devices (Android SDK version 28.0.3)
[✓] Chrome - develop for the web
[✓] Android Studio (version 3.5)
[✓] Connected device (2 available)""";
const String kCmdFlutterVersionArg = "version";
const String kCmdFlutterVersionArgOutput = """
v1.9.1+hotfix.4
v1.9.1+hotfix.3
v1.10.6
v1.10.5
v1.10.4
v1.10.3
v1.10.2
v1.9.1+hotfix.2
v1.10.1
v1.10.0
v1.9.1+hotfix.1
v1.9.7
v1.9.6
v1.9.5
v1.9.4
v1.9.3
v1.9.2
v1.9.1
v1.9.0
v1.8.4
v1.8.3
v1.7.8+hotfix.4
v1.8.2
v1.7.8+hotfix.3
v1.8.1
v1.7.8+hotfix.2
v1.7.8+hotfix.1
v1.8.0""";
