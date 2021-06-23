import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kExecuteKey = LogicalKeyboardKey.enter;
const _kNavigateBackKey = LogicalKeyboardKey.arrowUp;
const _kNavigateForwardKey = LogicalKeyboardKey.arrowDown;
const _kAutocompleteKey = LogicalKeyboardKey.tab;

class TerminalInputKeyboardListener extends StatelessWidget {
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
          if (eventKey == _kExecuteKey) {
            onExecuteCommand();
          } else if (eventKey == _kNavigateBackKey) {
            onNavigateHistoryBack();
          } else if (eventKey == _kNavigateForwardKey) {
            onNavigateHistoryForward();
          } else if (eventKey == _kAutocompleteKey) {
            onAutocomplete();
          }
        }
      },
      child: this.child,
    );
  }
}
