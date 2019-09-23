import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:terminal_resume_app/utils/constants.dart';

void main() {
  _setupLogger();
  runApp(TerminalResumeApp());
}

void _setupLogger() {
  if (kReleaseMode) {
    Logger.root.level = Level.OFF;
  } else {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('[${rec.time}][${rec.level}][${rec.loggerName}] ${rec.message}');
    });
  }
}

class TerminalResumeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        scaffoldBackgroundColor: kPrimaryColor,
        buttonTheme: ThemeData.dark().buttonTheme.copyWith(highlightColor: kAccentColor),
        highlightColor: kAccentColor,
        cursorColor: Colors.black,
        textSelectionColor: kAccentColor,
        textSelectionHandleColor: kAccentColor,
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'FiraCode'),
        primaryTextTheme: ThemeData.dark().primaryTextTheme.apply(fontFamily: 'FiraCode'),
        accentTextTheme: ThemeData.dark().accentTextTheme.apply(fontFamily: 'FiraCode'),
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(elevation: 0, color: kPrimaryColor),
      ),
      home: FlutterExperimentWarning(child: MainPage()),
    );
  }
}

final Logger _kLogger = Logger("main");

class FlutterExperimentWarning extends StatelessWidget {
  final Widget child;
  FlutterExperimentWarning({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Opacity(
              opacity: 0.50,
              child: FlatButton(
                child: Text("Warning! This is a Flutter experiment v1.10.5"),
                onPressed: () => _showWarning(context),
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
            FlatButton(highlightColor: kPrimaryColor, onPressed: () => Navigator.pop(ctx), child: Text("Ok"))
          ];
          return AlertDialog(title: Text("Warning"), content: Text("Experiment"), actions: _actions);
        });
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _incrementCounter() {
    setState(() {
      _kLogger.warning("message");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '23',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
