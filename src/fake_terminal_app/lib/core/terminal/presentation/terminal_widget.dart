import 'package:fake_terminal_app/core/terminal/presentation/terminal_input_widget.dart';
import 'package:fake_terminal_app/core/terminal/presentation/terminal_output_widget.dart';
import 'package:fake_terminal_app/core/terminal/presentation/top_back_widget.dart';
import 'package:fake_terminal_app/core/terminal/presentation/top_menu_widget.dart';
import 'package:flutter/material.dart';

const _kTopIconsPadding = EdgeInsets.all(8);

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
              const TerminalInputWidget(),
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
                child: const TopMenuWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
