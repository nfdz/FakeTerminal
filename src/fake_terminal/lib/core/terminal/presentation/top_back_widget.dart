import 'package:fake_terminal/core/terminal/provider/terminal_provider.dart';
import 'package:fake_terminal/core/texts/terminal_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBackWidget extends StatelessWidget {
  const TopBackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.read(terminalProvider.notifier).canExitTerminal()
        ? FloatingActionButton(
            key: null,
            mini: true,
            onPressed: context.read(terminalProvider.notifier).exitTerminal,
            tooltip: TerminalTexts.exitTooltip,
            child: Icon(
              Icons.arrow_back,
            ),
          )
        : SizedBox();
  }
}