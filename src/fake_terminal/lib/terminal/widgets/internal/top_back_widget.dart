import 'package:fake_terminal/icons/terminal_icons.dart';
import 'package:fake_terminal/terminal/providers/terminal_provider.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBackWidget extends ConsumerWidget {
  const TopBackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.read(terminalProvider.notifier).canExitTerminal()
        ? FloatingActionButton(
            key: null,
            mini: true,
            onPressed: ref.read(terminalProvider.notifier).exitTerminal,
            tooltip: TerminalTexts.exitTooltip,
            child: Icon(TerminalIcons.exitTerminal),
          )
        : SizedBox();
  }
}
