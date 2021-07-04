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
import 'mockito_extensions.dart';

@GenerateMocks([ThemeNotifier, TerminalNotifier])
void main() {
  Widget _createWidgetToTest({
    required ThemeSettings themeState,
    required TerminalState terminalState,
    required bool canExitTerminal,
  }) {
    final themeNotifier = MockThemeNotifier();
    when(themeNotifier.initializationComplete).thenAnswer((_) async => true);
    when(themeNotifier.addListener(any)).thenAnswerStateToListener(themeState);
    when(themeNotifier.state).thenReturn(themeState);
    final terminalNotifier = MockTerminalNotifier();
    when(terminalNotifier.addListener(any)).thenAnswerStateToListener(terminalState);
    when(terminalNotifier.canExitTerminal()).thenReturn(canExitTerminal);
    return ProviderScope(
      overrides: [
        themeProvider.overrideWithProvider(StateNotifierProvider((ref) => themeNotifier)),
        terminalProvider.overrideWithProvider(StateNotifierProvider((ref) => terminalNotifier)),
      ],
      child: EntryPointWidget(),
    );
  }

  Future<void> _testMainWidget(WidgetTester tester, ThemeSettings theme) async {
    await tester.pumpWidget(_createWidgetToTest(
      themeState: theme,
      terminalState: TerminalState(historyInput: [], output: []),
      canExitTerminal: true,
    ));

    expect(find.text(TerminalTexts.terminalInputPrefix), findsOneWidget);
    expect(find.text(TerminalTexts.terminalInputHint), findsOneWidget);
    expect(find.byIcon(TerminalIcons.executeCommand), findsOneWidget);
    expect(find.byIcon(TerminalIcons.exitTerminal), findsOneWidget);
    expect(find.byIcon(TerminalIcons.information), findsOneWidget);
  }

  testWidgets('given dark theme then render main page empty state', (WidgetTester tester) async {
    await _testMainWidget(tester, ThemeSettings.dark);
    expect(find.byIcon(TerminalIcons.darkTheme), findsOneWidget);
  });

  testWidgets('given light theme then render main page empty state', (WidgetTester tester) async {
    await _testMainWidget(tester, ThemeSettings.light);
    expect(find.byIcon(TerminalIcons.lightTheme), findsOneWidget);
  });
}
