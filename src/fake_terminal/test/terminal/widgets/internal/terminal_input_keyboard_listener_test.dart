import 'package:fake_terminal/terminal/widgets/internal/terminal_input_keyboard_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('given tab key down then invoke autocomplete callback', (WidgetTester tester) async {
    var autocompleteInvoked = false;
    final focusNode = FocusNode();
    await tester.pumpWidget(TerminalInputKeyboardListener(
      focusNode: focusNode,
      onAutocomplete: () {
        autocompleteInvoked = true;
      },
      onExecuteCommand: () {},
      onNavigateHistoryBack: () {},
      onNavigateHistoryForward: () {},
      child: SizedBox(),
    ));

    focusNode.requestFocus();
    await tester.pumpAndSettle();
    await tester.sendKeyDownEvent(LogicalKeyboardKey.tab);

    expect(autocompleteInvoked, true);
  });
  testWidgets('given arrow up key down then invoke navigate back callback', (WidgetTester tester) async {
    var navigateBackInvoked = false;
    final focusNode = FocusNode();
    await tester.pumpWidget(TerminalInputKeyboardListener(
      focusNode: focusNode,
      onAutocomplete: () {},
      onExecuteCommand: () {},
      onNavigateHistoryBack: () {
        navigateBackInvoked = true;
      },
      onNavigateHistoryForward: () {},
      child: SizedBox(),
    ));

    focusNode.requestFocus();
    await tester.pumpAndSettle();
    await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowUp);

    expect(navigateBackInvoked, true);
  });
  testWidgets('given arrow down key down then invoke navigate forward callback', (WidgetTester tester) async {
    var navigateForwardInvoked = false;
    final focusNode = FocusNode();
    await tester.pumpWidget(TerminalInputKeyboardListener(
      focusNode: focusNode,
      onAutocomplete: () {},
      onExecuteCommand: () {},
      onNavigateHistoryBack: () {},
      onNavigateHistoryForward: () {
        navigateForwardInvoked = true;
      },
      child: SizedBox(),
    ));

    focusNode.requestFocus();
    await tester.pumpAndSettle();
    await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowDown);

    expect(navigateForwardInvoked, true);
  });
}
