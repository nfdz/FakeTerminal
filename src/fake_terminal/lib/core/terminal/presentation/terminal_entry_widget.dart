import 'package:fake_terminal/core/terminal/model/terminal_line.dart';
import 'package:flutter/material.dart';

class TerminalEntryWidget extends StatelessWidget {
  final TerminalLine entry;
  TerminalEntryWidget(this.entry);

  @override
  Widget build(BuildContext context) {
    final isCommandType = entry.type == LineType.command;
    final textLineStyle = isCommandType ? Theme.of(context).textTheme.bodyText2 : Theme.of(context).textTheme.bodyText1;
    if (entry.prefix?.isNotEmpty == true) {
      return RichText(
        text: TextSpan(
          style: Theme.of(context).accentTextTheme.bodyText2,
          text: entry.prefix,
          children: <TextSpan>[
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
