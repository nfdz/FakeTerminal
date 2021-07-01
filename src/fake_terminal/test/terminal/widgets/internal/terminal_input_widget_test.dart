import 'package:fake_terminal/icons/terminal_icons.dart';
import 'package:fake_terminal/terminal/providers/terminal_provider.dart';
import 'package:fake_terminal/terminal/widgets/internal/terminal_input_keyboard_listener.dart';
import 'package:fake_terminal/terminal/widgets/internal/terminal_input_widget.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sizer/sizer.dart';

import 'terminal_input_widget_test.mocks.dart';

@GenerateMocks([TerminalNotifier])
void main() {
  Widget _createWidgetToTest({
    FocusNode? keyboardInputNode,
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
              body: TerminalInputWidget(keyboardInputNode: keyboardInputNode),
            ),
          );
        },
      ),
    );
  }

  group('keyboard listener', () {
    testWidgets(
        'given autocomplete key event then invoke autocomplete with the commandLine and replace the input with the value',
        (WidgetTester tester) async {
      final commandLine = "myComma";
      final completeCommand = "myCommandLine";

      final terminalNotifier = MockTerminalNotifier();
      when(terminalNotifier.autocomplete(any)).thenReturn(completeCommand);

      final focusNode = FocusNode();
      await tester.pumpWidget(_createWidgetToTest(
        keyboardInputNode: focusNode,
        terminalNotifier: terminalNotifier,
      ));

      await tester.enterText(find.byType(TextField), commandLine);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      await tester.sendKeyDownEvent(TerminalInputKeyboardListener.autocompleteKey);

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller!.text, completeCommand);

      verify(terminalNotifier.autocomplete(commandLine)).called(1);
    });
    testWidgets(
        'given navigate back key event then invoke navigateHistoryBack with the commandLine and replace the input with the value',
        (WidgetTester tester) async {
      final commandLine = "myCommandLine4";
      final previousCommand = "myCommandLine3";

      final terminalNotifier = MockTerminalNotifier();
      when(terminalNotifier.navigateHistoryBack(any)).thenReturn(previousCommand);

      final focusNode = FocusNode();
      await tester.pumpWidget(_createWidgetToTest(
        keyboardInputNode: focusNode,
        terminalNotifier: terminalNotifier,
      ));

      await tester.enterText(find.byType(TextField), commandLine);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      await tester.sendKeyDownEvent(TerminalInputKeyboardListener.navigateBackKey);

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller!.text, previousCommand);

      verify(terminalNotifier.navigateHistoryBack(commandLine)).called(1);
    });
    testWidgets(
        'given navigate forward key event then invoke navigateHistoryForward with the commandLine and replace the input with the value',
        (WidgetTester tester) async {
      final commandLine = "myCommandLine3";
      final forwardCommand = "myCommandLine4";

      final terminalNotifier = MockTerminalNotifier();
      when(terminalNotifier.navigateHistoryForward(any)).thenReturn(forwardCommand);

      final focusNode = FocusNode();
      await tester.pumpWidget(_createWidgetToTest(
        keyboardInputNode: focusNode,
        terminalNotifier: terminalNotifier,
      ));

      await tester.enterText(find.byType(TextField), commandLine);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      await tester.sendKeyDownEvent(TerminalInputKeyboardListener.navigateForwardKey);

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller!.text, forwardCommand);

      verify(terminalNotifier.navigateHistoryForward(commandLine)).called(1);
    });
  });

  testWidgets('given tap execute icon then invoke executeCommand with the commandLine and clear the input',
      (WidgetTester tester) async {
    final commandLine = "myCommandLine";

    final terminalNotifier = MockTerminalNotifier();
    when(terminalNotifier.executeCommand(any)).thenAnswer((_) {});

    await tester.pumpWidget(_createWidgetToTest(
      terminalNotifier: terminalNotifier,
    ));

    await tester.enterText(find.byType(TextField), commandLine);

    await tester.tap(find.byIcon(TerminalIcons.executeCommand));

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.controller!.text.isEmpty, true);

    verify(terminalNotifier.executeCommand(commandLine)).called(1);
  });

  testWidgets('given tap text input action then invoke executeCommand with the commandLine and clear the input',
      (WidgetTester tester) async {
    final commandLine = "myCommandLine";

    final terminalNotifier = MockTerminalNotifier();
    when(terminalNotifier.executeCommand(any)).thenAnswer((_) {});

    await tester.pumpWidget(_createWidgetToTest(
      terminalNotifier: terminalNotifier,
    ));

    await tester.enterText(find.byType(TextField), commandLine);

    await tester.testTextInput.receiveAction(TextInputAction.done);

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.controller!.text.isEmpty, true);

    verify(terminalNotifier.executeCommand(commandLine)).called(1);
  });
}
