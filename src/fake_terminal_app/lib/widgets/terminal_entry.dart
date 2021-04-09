import 'package:fake_terminal_app/model/terminal_content.dart';
import 'package:flutter/material.dart';
import 'package:fake_terminal_app/utils/constants.dart';

class TerminalEntry extends StatelessWidget {
  final TerminalLine entry;
  final TextStyle textStyle;
  TerminalEntry(this.entry, {this.textStyle = kDefaultTextStyle});

  @override
  Widget build(BuildContext context) {
    bool isCmd = entry is CommandLine;
    if (isCmd) {
      return RichText(
        text: TextSpan(
          style: textStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: kTerminalAccentColor,
          ),
          text: kTerminalPrefix,
          children: <TextSpan>[
            TextSpan(
                text: entry.line,
                style: textStyle.copyWith(color: Colors.white)),
          ],
        ),
      );
    } else {
      return Text(entry.line, style: textStyle);
    }
  }
}
