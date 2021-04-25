import 'package:fake_terminal/terminal/widgets/internal/terminal_input_widget.dart';
import 'package:fake_terminal/terminal/widgets/internal/terminal_output_widget.dart';
import 'package:fake_terminal/terminal/widgets/internal/top_back_widget.dart';
import 'package:fake_terminal/terminal/widgets/internal/top_menu_widget.dart';
import 'package:flutter/material.dart';

const _kTopIconsPadding = EdgeInsets.all(16);

class TerminalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              Expanded(
                child: const TerminalOutputWidget(),
              ),
              TerminalInputWidget(),
            ]),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: _kTopIconsPadding,
                child: const TopBackWidget(),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: _kTopIconsPadding,
                child: TopMenuWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
