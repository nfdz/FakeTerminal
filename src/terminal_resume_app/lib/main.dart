import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:terminal_resume_app/utils/constants.dart';
import 'package:terminal_resume_app/widgets/terminal.dart';
import 'package:terminal_resume_app/widgets/warning_exit_wrapper.dart';

void main() {
  _setupLogger();
  runApp(TerminalResumeApp());
}

void _setupLogger() {
  if (kReleaseMode) {
    Logger.root.level = Level.OFF;
  } else {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('[${rec.time}][${rec.level}][${rec.loggerName}] ${rec.message}');
    });
  }
}

class TerminalResumeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        scaffoldBackgroundColor: kPrimaryColor,
        buttonTheme: ThemeData.dark().buttonTheme.copyWith(highlightColor: kAccentColor),
        highlightColor: kAccentColor,
        cursorColor: Colors.black,
        textSelectionColor: kAccentColor,
        textSelectionHandleColor: kAccentColor,
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'FiraCode'),
        primaryTextTheme: ThemeData.dark().primaryTextTheme.apply(fontFamily: 'FiraCode'),
        accentTextTheme: ThemeData.dark().accentTextTheme.apply(fontFamily: 'FiraCode'),
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(elevation: 0, color: kPrimaryColor),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WarningExitWrapper(child: Terminal());
  }
}
