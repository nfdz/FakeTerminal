import 'package:fake_terminal/terminal/models/terminal_line.dart';
import 'package:flutter/material.dart';

class TerminalEntryWidget extends StatelessWidget {
  static const prefixKey = Key('terminal_entry_widget_prefix');

  final TerminalLine entry;
  TerminalEntryWidget(this.entry);

  @override
  Widget build(BuildContext context) {
    final isCommandType = entry.type == LineType.command;
    final textLineStyle = isCommandType ? Theme.of(context).textTheme.bodyMedium : Theme.of(context).textTheme.bodyLarge;
    if (entry.prefix?.isNotEmpty == true) {
      return RichText(
        key: prefixKey,
        text: TextSpan(
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
          text: entry.prefix,
          children: <TextSpan>[
            TextSpan(
              text: " ",
              style: textLineStyle,
            ),
            TextSpan(
              text: entry.line,
              style: textLineStyle,
            ),
          ],
        ),
      );
    } else {
      return Text(entry.line, style: textLineStyle);
    }
  }
}
