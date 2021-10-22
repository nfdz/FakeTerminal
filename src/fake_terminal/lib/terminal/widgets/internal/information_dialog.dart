import 'dart:math' as Math;

import 'package:fake_terminal/icons/terminal_icons.dart';
import 'package:fake_terminal/terminal/providers/terminal_provider.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const double _kDialogMaxWidth = 500;

class InformationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _DialogContainer(),
    );
  }
}

class _DialogContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double width = Math.min(widthScreen, _kDialogMaxWidth);
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      width: width,
      child: Stack(
        children: <Widget>[
          _DialogContent(),
          Positioned(
            right: 0.0,
            child: _DialogCloseIcon(),
          ),
        ],
      ),
    );
  }
}

const double _kDialogCornerRadius = 8.0;
const double _kDialogContentVerticalPadding = 12.0;
const double _kDialogContentHorizontalPadding = 24.0;

class _DialogContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 18.0,
      ),
      margin: EdgeInsets.only(top: 13.0, right: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(_kDialogCornerRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: _kDialogContentVerticalPadding,
              horizontal: _kDialogContentHorizontalPadding,
            ),
            child: Text(TerminalTexts.informationDialogTitle, style: Theme.of(context).textTheme.subtitle1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: _kDialogContentHorizontalPadding),
            child: Text(TerminalTexts.informationDialogContent, style: Theme.of(context).textTheme.subtitle2),
          ),
          SizedBox(height: _kDialogContentVerticalPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => context.read(terminalProvider.notifier).navigateToTerminalRepository(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    TerminalTexts.openGithubButton.toUpperCase(),
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DialogCloseIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Semantics(
        value: TerminalTexts.closeDialogSemantic,
        child: MaterialButton(
          minWidth: 0,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          shape: CircleBorder(),
          onPressed: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Icon(
              TerminalIcons.closeDialog,
              size: 18,
              color: Theme.of(context).floatingActionButtonTheme.foregroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
