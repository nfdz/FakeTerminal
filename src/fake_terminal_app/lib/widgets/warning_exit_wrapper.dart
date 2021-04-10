import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:fake_terminal_app/utils/constants.dart';
import 'package:fake_terminal_app/utils/html_comm_workaround.dart';
import 'dart:math' as Math;

final Logger _kLogger = Logger("WarningExitWrapper");
const double _kDialogMaxWidth = 500;

class WarningExitWrapper extends StatelessWidget {
  final Widget child;
  WarningExitWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: FlatButton(
              color: Theme.of(context).cardColor,
              child: Text(kWarningButton),
              onPressed: () => _showWarning(context),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: FloatingActionButton(
              key: null,
              mini: true,
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () {
                _kLogger.info("On back pressed");
                HtmlCommWorkAround.goBackHistory();
              },
              tooltip: kBackTooltip,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showWarning(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          final double widthScreen = MediaQuery.of(context).size.width;
          final double width = Math.min(widthScreen, _kDialogMaxWidth);
          return AlertDialog(
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
            content: Container(
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        highlightColor: Theme.of(context).accentColor,
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close),
                      ),
                    ),
                    Text(
                      kWarningDialogTitle,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(height: 9),
                    Text(
                      kWarningDialogContent,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(height: 6),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                        highlightColor: Theme.of(context).accentColor,
                        onPressed: () => HtmlCommWorkAround.goGithub(),
                        child: Text(kWarningDialogGithub),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
