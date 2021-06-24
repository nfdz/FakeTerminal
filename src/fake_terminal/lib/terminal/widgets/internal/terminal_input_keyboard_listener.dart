import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TerminalInputKeyboardListener extends StatelessWidget {
  static const executeKey = LogicalKeyboardKey.enter;
  static const navigateBackKey = LogicalKeyboardKey.arrowUp;
  static const navigateForwardKey = LogicalKeyboardKey.arrowDown;
  static const autocompleteKey = LogicalKeyboardKey.tab;

  final Widget child;
  final FocusNode focusNode;
  final Function onExecuteCommand;
  final Function onNavigateHistoryBack;
  final Function onNavigateHistoryForward;
  final Function onAutocomplete;

  const TerminalInputKeyboardListener({
    Key? key,
    required this.child,
    required this.focusNode,
    required this.onExecuteCommand,
    required this.onNavigateHistoryBack,
    required this.onNavigateHistoryForward,
    required this.onAutocomplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: this.focusNode,
      onKey: (event) {
        if (event.runtimeType == RawKeyDownEvent) {
          final eventKey = event.logicalKey;
          if (eventKey == executeKey) {
            onExecuteCommand();
          } else if (eventKey == navigateBackKey) {
            onNavigateHistoryBack();
          } else if (eventKey == navigateForwardKey) {
            onNavigateHistoryForward();
          } else if (eventKey == autocompleteKey) {
            onAutocomplete();
          }
        }
      },
      child: this.child,
    );
  }
}
