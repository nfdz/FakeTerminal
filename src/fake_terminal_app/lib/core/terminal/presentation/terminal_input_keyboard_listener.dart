import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

const int _kKeyCodeEnter = 54;
const int _kKeyCodeUp = 106;
const int _kKeyCodeDown = 108;
const int _kKeyCodeTab = 0x10007002b;

final Logger _kLogger = Logger("TerminalInputKeyboardListener");

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
          switch (event.logicalKey.keyId) {
            case _kKeyCodeEnter:
              _kLogger.fine("Enter key down");
              onExecuteCommand();
              break;
            case _kKeyCodeUp:
              _kLogger.fine("Up key down");
              onNavigateHistoryBack();
              break;
            case _kKeyCodeDown:
              _kLogger.fine("Down key down");
              onNavigateHistoryForward();
              break;
            case _kKeyCodeTab:
              _kLogger.fine("Tab key down");
              onAutocomplete();
              break;
          }
        }
      },
      child: this.child,
    );
  }
}
