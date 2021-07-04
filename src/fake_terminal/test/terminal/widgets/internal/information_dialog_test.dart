import 'package:fake_terminal/icons/terminal_icons.dart';
import 'package:fake_terminal/terminal/providers/terminal_provider.dart';
import 'package:fake_terminal/terminal/widgets/internal/information_dialog.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sizer/sizer.dart';

import 'information_dialog_test.mocks.dart';

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
              body: InformationDialog(),
            ),
          );
        },
      ),
    );
  }

  testWidgets('show title and content', (WidgetTester tester) async {
    await tester.pumpWidget(_createWidgetToTest());

    expect(find.text(TerminalTexts.informationDialogTitle), findsOneWidget);
    expect(find.text(TerminalTexts.informationDialogContent), findsOneWidget);
  });

  testWidgets('tap close icon dismiss the dialog', (WidgetTester tester) async {
    await tester.pumpWidget(_createWidgetToTest());

    await tester.tap(find.byIcon(TerminalIcons.closeDialog));
    await tester.pumpAndSettle();
    expect(find.byType(InformationDialog), findsNothing);
  });

  testWidgets('tap open repository button invoke', (WidgetTester tester) async {
    final terminalNotifier = MockTerminalNotifier();
    when(terminalNotifier.navigateToTerminalRepository()).thenReturn(null);

    await tester.pumpWidget(_createWidgetToTest(terminalNotifier: terminalNotifier));

    await tester.tap(find.text(TerminalTexts.openGithubButton));

    verify(terminalNotifier.navigateToTerminalRepository()).called(1);
  });
}
