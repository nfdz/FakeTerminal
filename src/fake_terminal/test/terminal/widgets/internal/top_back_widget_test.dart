import 'package:fake_terminal/icons/terminal_icons.dart';
import 'package:fake_terminal/terminal/providers/terminal_provider.dart';
import 'package:fake_terminal/terminal/widgets/internal/top_back_widget.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sizer/sizer.dart';

import 'top_back_widget_test.mocks.dart';

@GenerateMocks([TerminalNotifier])
void main() {
  Widget _createWidgetToTest({
    TerminalNotifier? terminalNotifier,
  }) {
    return ProviderScope(
      overrides: [
        terminalProvider
            .overrideWithProvider(StateNotifierProvider((ref) => terminalNotifier ?? MockTerminalNotifier())),
      ],
      child: Sizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            theme: ThemeSettings.dark.data(),
            home: Scaffold(
              body: TopBackWidget(),
            ),
          );
        },
      ),
    );
  }

  testWidgets('given canExitTerminal is false then show no exit icon', (WidgetTester tester) async {
    final terminalNotifier = MockTerminalNotifier();
    when(terminalNotifier.canExitTerminal()).thenReturn(false);

    await tester.pumpWidget(_createWidgetToTest(
      terminalNotifier: terminalNotifier,
    ));

    expect(find.byIcon(TerminalIcons.exitTerminal), findsNothing);
  });

  testWidgets('given canExitTerminal is true then show exit icon', (WidgetTester tester) async {
    final terminalNotifier = MockTerminalNotifier();
    when(terminalNotifier.canExitTerminal()).thenReturn(true);

    await tester.pumpWidget(_createWidgetToTest(
      terminalNotifier: terminalNotifier,
    ));

    expect(find.byIcon(TerminalIcons.exitTerminal), findsOneWidget);
  });

  testWidgets('given the user tap the icon then invoke exitTerminal', (WidgetTester tester) async {
    final terminalNotifier = MockTerminalNotifier();
    when(terminalNotifier.canExitTerminal()).thenReturn(true);
    when(terminalNotifier.exitTerminal()).thenReturn(null);

    await tester.pumpWidget(_createWidgetToTest(
      terminalNotifier: terminalNotifier,
    ));

    await tester.tap(find.byIcon(TerminalIcons.exitTerminal));

    verify(terminalNotifier.exitTerminal()).called(1);
  });
}
