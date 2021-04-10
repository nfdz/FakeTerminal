import 'package:fake_terminal_app/model/terminal_content.dart';
import 'package:flutter/material.dart';
import 'package:fake_terminal_app/utils/constants.dart';

class TerminalEntry extends StatelessWidget {
  final TerminalLine entry;
  TerminalEntry(this.entry);

  @override
  Widget build(BuildContext context) {
    bool isCmd = entry is CommandLine;
    if (isCmd) {
      return RichText(
        text: TextSpan(
          style: Theme.of(context).accentTextTheme.bodyText2,
          text: kTerminalPrefix,
          children: <TextSpan>[
            TextSpan(text: entry.line, style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      );
    } else {
      return Text(entry.line, style: Theme.of(context).textTheme.bodyText1);
    }
  }
}
