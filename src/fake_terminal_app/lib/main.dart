import 'package:fake_terminal_app/core/theme/dark_theme_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:fake_terminal_app/utils/constants.dart';
import 'package:fake_terminal_app/widgets/terminal.dart';
import 'package:fake_terminal_app/widgets/warning_exit_wrapper.dart';

void main() {
  _setupLogger();
  runApp(FakeTerminalApp());
}

void _setupLogger() {
  if (kReleaseMode) {
    Logger.root.level = Level.OFF;
  } else {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('[${record.time}][${record.level.name}][${record.loggerName}] ${record.message}');
    });
  }
}

class FakeTerminalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: darkThemeData,
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
