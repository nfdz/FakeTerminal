import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            padding: const EdgeInsets.all(9.0),
            child: Opacity(
              opacity: 0.70,
              child: FlatButton(
                child: Text("Warning! This is a Flutter experiment v1.10.6"),
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
              tooltip: 'Back',
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
          return AlertDialog(title: Text("Warning"), content: Text("Experiment"), actions: _actions);
        });
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<TerminalLine> _content = [
    ResultLine("\n\n"),
  ];
  TextEditingController _cmdTextController = TextEditingController();
  FocusNode _inputNode = FocusNode();
  FocusNode _keyInputNode = FocusNode();

  void _executeCmd() {
    FocusScope.of(context).unfocus();
    String cmd = _cmdTextController.text;
    _cmdTextController.clear();
    _kLogger.info("Executing command: $cmd");
    _content.insert(0, CommandLine(cmd));
    if (cmd.isNotEmpty == true) {
      _content.insert(0, ResultLine(_getResult(cmd)));
    }
    setState(() {
      _inputNode.requestFocus();
    });
  }

  String _getResult(String cmd) {
    switch (cmd) {
      default:
        return kCmdNotFound.replaceFirst("{cmd}", cmd.split(" ").first);
    }
  }

  @override
  void dispose() {
    _inputNode.dispose();
    _keyInputNode.dispose();
    _cmdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.fromLTRB(9, 0, 9, 9),
                    itemCount: _content.length,
                    itemBuilder: (BuildContext context, int index) {
                      final entry = _content[index];
                      bool isCmd = entry is CommandLine;
                      if (isCmd) {
                        return RichText(
                          text: TextSpan(
                            style: kDefaultTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kTerminalAccentColor,
                            ),
                            text: kTerminalPrefix,
                            children: <TextSpan>[
                              TextSpan(text: entry.line, style: kDefaultTextStyle.copyWith(color: Colors.white)),
                            ],
                          ),
                        );
                      } else {
                        return Text(
                          entry.line,
                          style: kDefaultTextStyle,
                        );
                      }
                    }),
              ),
            ),
            Container(
              width: double.infinity,
              height: 70,
              color: kLightPrimaryColor,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 9),
                  Text(
                    kTerminalPrefix,
                    style: kDefaultTextStyle.copyWith(color: kTerminalAccentColor, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    child: RawKeyboardListener(
                      focusNode: _keyInputNode,
                      onKey: (event) {
                        if (event.runtimeType == RawKeyDownEvent && (event.logicalKey.keyId == 54)) {
                          _kLogger.fine("Enter key down");
                          _executeCmd();
                        }
                      },
                      child: TextField(
                        focusNode: _inputNode,
                        maxLines: 1,
                        controller: _cmdTextController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.newline,
                        style: kDefaultTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter a command...',
                        ),
                        onEditingComplete: () => _executeCmd(),
                        onSubmitted: (text) => _executeCmd(),
                      ),
                    ),
                  ),
                  SizedBox(width: 9),
                  FloatingActionButton(
                    key: null,
                    backgroundColor: kPrimaryColor,
                    onPressed: _executeCmd,
                    mini: true,
                    tooltip: 'Execute command',
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                  SizedBox(width: 9),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TerminalLine {
  final String line;
  TerminalLine(this.line);
}

class CommandLine extends TerminalLine {
  CommandLine(String line) : super(line);
}

class ResultLine extends TerminalLine {
  ResultLine(String line) : super(line);
}
