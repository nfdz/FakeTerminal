import 'package:fake_terminal/icons/terminal_icons.dart';
import 'package:fake_terminal/main.dart';
import 'package:fake_terminal/terminal/models/terminal_state.dart';
import 'package:fake_terminal/terminal/providers/terminal_provider.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:fake_terminal/theme/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_widget_test.mocks.dart';

@GenerateMocks([ThemeNotifier, TerminalNotifier])
void main() {
  Widget _createWidgetToTest({
    required ThemeSettings themeState,
    required TerminalState terminalState,
  }) {
    final themeNotifier = MockThemeNotifier();
    when(themeNotifier.initializationComplete).thenAnswer((_) async => true);
    when(themeNotifier.addListener(any)).thenAnswer((invocation) {
      final listener = invocation.positionalArguments[0] as void Function(ThemeSettings state);
      listener(themeState);
      return () {};
    });
    when(themeNotifier.state).thenReturn(themeState);
    final terminalNotifier = MockTerminalNotifier();
    when(terminalNotifier.addListener(any)).thenAnswer((invocation) {
      final listener = invocation.positionalArguments[0] as void Function(TerminalState state);
      listener(terminalState);
      return () {};
    });
    when(terminalNotifier.canExitTerminal()).thenReturn(true);
    return ProviderScope(
      overrides: [
        themeProvider.overrideWithProvider(StateNotifierProvider((ref) => themeNotifier)),
        terminalProvider.overrideWithProvider(StateNotifierProvider((ref) => terminalNotifier)),
      ],
      child: EntryPointWidget(),
    );
  }

  testWidgets('Render main page', (WidgetTester tester) async {
    await tester.pumpWidget(_createWidgetToTest(
      themeState: ThemeSettings.dark,
      terminalState: TerminalState(historyInput: [], output: []),
    ));

    expect(find.text(TerminalTexts.terminalInputPrefix), findsOneWidget);
    expect(find.text(TerminalTexts.terminalInputHint), findsOneWidget);
    expect(find.byIcon(TerminalIcons.executeCommand), findsOneWidget);
    expect(find.byIcon(TerminalIcons.exitTerminal), findsOneWidget);
    expect(find.byIcon(TerminalIcons.darkTheme), findsOneWidget);
    expect(find.byIcon(TerminalIcons.information), findsOneWidget);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
