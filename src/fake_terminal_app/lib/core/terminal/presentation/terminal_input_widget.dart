import 'package:fake_terminal_app/core/terminal/presentation/terminal_input_keyboard_listener.dart';
import 'package:fake_terminal_app/core/terminal/provider/terminal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerminalInputWidget extends StatefulWidget {
  const TerminalInputWidget({Key? key}) : super(key: key);

  @override
  _TerminalInputWidgetState createState() => _TerminalInputWidgetState();
}

class _TerminalInputWidgetState extends State<TerminalInputWidget> {
  TextEditingController _cmdTextController = TextEditingController();
  FocusNode _inputNode = FocusNode();
  FocusNode _keyInputNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final terminalNotifier = context.read(terminalProvider.notifier);
    return Container(
      width: double.infinity,
      height: 60,
      color: Theme.of(context).cardColor,
      child: Row(
        children: <Widget>[
          SizedBox(width: 9),
          Text(
            terminalNotifier.terminalInputPrefix,
            style: Theme.of(context).accentTextTheme.bodyText2,
          ),
          SizedBox(width: 9),
          Expanded(
            child: TerminalInputKeyboardListener(
              focusNode: _keyInputNode,
              onExecuteCommand: _sendCommand,
              onNavigateHistoryBack: _navigateHistoryUp,
              onNavigateHistoryForward: _navigateHistoryDown,
              onAutocomplete: _tryToAutocomplete,
              child: TerminalInputTextField(
                focusNode: _inputNode,
                controller: _cmdTextController,
                hintText: terminalNotifier.terminalInputHint,
                onExecuteCommand: _sendCommand,
              ),
            ),
          ),
          SizedBox(width: 9),
          FloatingActionButton(
            key: null,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: _sendCommand,
            mini: true,
            tooltip: terminalNotifier.executeCommandTooltip,
            child: Icon(Icons.send, color: Colors.white),
          ),
          SizedBox(width: 9),
        ],
      ),
    );
  }

  void _sendCommand() {
    setState(() {
      FocusScope.of(context).unfocus();
      String cmd = _cmdTextController.text;
      _cmdTextController.clear();
      //_terminalBrain.executeCommand(cmd);
      _inputNode.requestFocus();
    });
  }

  void _navigateHistoryUp() {
    // String? upCmd = _terminalBrain.getHistoryUp();
    // if (upCmd != null) {
    //   setState(() {
    //     FocusScope.of(context).unfocus();
    //     _cmdTextController.text = upCmd;
    //     _inputNode.requestFocus();
    //   });
    // }
  }

  void _navigateHistoryDown() {
    // String? downCmd = _terminalBrain.getHistoryDown();
    // if (downCmd != null) {
    //   setState(() {
    //     FocusScope.of(context).unfocus();
    //     _cmdTextController.text = downCmd;
    //     _inputNode.requestFocus();
    //   });
    // }
  }

  void _tryToAutocomplete() {
    // String cmd = _cmdTextController.text;
    // String fullCmd = "";
    // if (cmd.isNotEmpty) {
    //   for (Command availableCommand in kAvailableCommands) {
    //     if (availableCommand.cmd.startsWith(cmd)) {
    //       if (availableCommand.cmd != cmd) {
    //         fullCmd = availableCommand.cmd;
    //       }
    //       break;
    //     }
    //   }
    // }
    // if (fullCmd.isNotEmpty) {
    //   setState(() {
    //     FocusScope.of(context).unfocus();
    //     _cmdTextController.text = fullCmd;
    //     _inputNode.requestFocus();
    //   });
    // }
  }
}

class TerminalInputTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final Function onExecuteCommand;

  const TerminalInputTextField({
    Key? key,
    required this.focusNode,
    required this.controller,
    required this.hintText,
    required this.onExecuteCommand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: this.focusNode,
      maxLines: 1,
      controller: this.controller,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.newline,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: this.hintText,
      ),
      onEditingComplete: () => this.onExecuteCommand(),
      onSubmitted: (text) => this.onExecuteCommand(),
    );
  }
}
