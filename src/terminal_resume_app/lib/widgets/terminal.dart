import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:terminal_resume_app/utils/constants.dart';
import 'package:terminal_resume_app/utils/terminal_brain.dart';
import 'package:terminal_resume_app/widgets/terminal_entry.dart';

final Logger _kLogger = Logger("Terminal");

class Terminal extends StatefulWidget {
  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  final TerminalBrain _terminalBrain = TerminalBrain();

  TextEditingController _cmdTextController = TextEditingController();
  FocusNode _inputNode = FocusNode();
  FocusNode _keyInputNode = FocusNode();

  @override
  void dispose() {
    _inputNode.dispose();
    _keyInputNode.dispose();
    _cmdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final TextStyle responsiveTextStyle = width > kSmallerToBigWidth
        ? kDefaultTextStyle
        : width > kSmallestToSmallerWidth ? kSmallerTextStyle : kSmallestTextStyle;
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
                  itemCount: _terminalBrain.contentCount,
                  itemBuilder: (BuildContext context, int index) =>
                      TerminalEntry(_terminalBrain.entryAt(index), textStyle: responsiveTextStyle),
                ),
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
                    style: responsiveTextStyle.copyWith(color: kTerminalAccentColor, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    child: RawKeyboardListener(
                      focusNode: _keyInputNode,
                      onKey: (event) {
                        if (event.runtimeType == RawKeyDownEvent && (event.logicalKey.keyId == 54)) {
                          _kLogger.fine("Enter key down");
                          _sendCommand();
                        }
                      },
                      child: TextField(
                        focusNode: _inputNode,
                        maxLines: 1,
                        controller: _cmdTextController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.newline,
                        style: responsiveTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: kCommandBoxHint,
                        ),
                        onEditingComplete: () => _sendCommand(),
                        onSubmitted: (text) => _sendCommand(),
                      ),
                    ),
                  ),
                  SizedBox(width: 9),
                  FloatingActionButton(
                    key: null,
                    backgroundColor: kPrimaryColor,
                    onPressed: _sendCommand,
                    mini: true,
                    tooltip: kSendCommandTooltip,
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

  void _sendCommand() {
    setState(() {
      FocusScope.of(context).unfocus();
      String cmd = _cmdTextController.text;
      _cmdTextController.clear();
      _terminalBrain.executeCommand(cmd);
      _inputNode.requestFocus();
    });
  }
}
