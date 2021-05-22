import 'package:fake_terminal/terminal/widgets/terminal_widget.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:fake_terminal/theme/providers/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:sizer/sizer.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';

void main() {
  _setupLogger();
  runApp(ProviderScope(
    child: EntryPointWidget(),
  ));
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

class EntryPointWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.read(themeProvider.notifier);
    return FutureBuilder(
      future: themeNotifier.initializationComplete,
      builder: (context, snapshot) {
        return Sizer(builder: (context, orientation, screenType) {
          return FakeTerminalApp();
        });
      },
    );
  }
}

class FakeTerminalApp extends ConsumerWidget {
  const FakeTerminalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: TerminalTexts.appName,
      theme: theme.data(),
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
