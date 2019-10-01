import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:terminal_resume_app/utils/constants.dart';

final Logger _kLogger = Logger("WarningExitWrapper");

class WarningExitWrapper extends StatelessWidget {
  final Widget child;
  WarningExitWrapper({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Opacity(
              opacity: 0.70,
              child: FlatButton(
                child: Text("Warning! This is a Flutter experiment v1.10.6", style: kSmallestTextStyle),
                onPressed: () => _showWarning(context),
              ),
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
              backgroundColor: kAccentColor,
              onPressed: () {
                _kLogger.info("On back pressed");
                // TODO
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
          List<Widget> _actions = <Widget>[
            FlatButton(highlightColor: kAccentColor, onPressed: () => Navigator.pop(ctx), child: Text("Ok"))
          ];
          return AlertDialog(
            title: Text(
              kWarningDialogTitle,
              style: kDefaultTextStyle,
            ),
            content: Text(
              kWarningDialogContent,
              style: kSmallerTextStyle,
            ),
            actions: _actions,
          );
        });
  }
}
