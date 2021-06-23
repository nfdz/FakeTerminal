import 'package:fake_terminal/terminal/widgets/internal/terminal_input_keyboard_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('tab key down invoke autocomplete callback', (WidgetTester tester) async {
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
}
