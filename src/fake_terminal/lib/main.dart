import 'package:fake_terminal/core/terminal/presentation/terminal_widget.dart';
import 'package:fake_terminal/core/texts/terminal_texts.dart';
import 'package:fake_terminal/core/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

void main() {
  _setupLogger();
  runApp(
    const ProviderScope(child: FakeTerminalApp()),
  );
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

class FakeTerminalApp extends ConsumerWidget {
  const FakeTerminalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = watch(themeProvider);
    return MaterialApp(
      title: TerminalTexts.appName,
      theme: theme.data,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TerminalWidget();
  }
}
