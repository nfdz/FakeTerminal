import 'package:fake_terminal_app/core/terminal/model/terminal_state.dart';
import 'package:fake_terminal_app/core/terminal/presentation/terminal_input_keyboard_listener.dart';
import 'package:fake_terminal_app/core/terminal/provider/terminal_provider.dart';
import 'package:fake_terminal_app/core/texts/terminal_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    return ProviderListener(
      provider: terminalProvider,
      onChange: (context, TerminalState state) {
        final newInput = state.input;
        if (newInput != null) {
          setState(() {
            _cmdTextController.text = newInput;
          });
        }
      },
      child: Container(
        width: double.infinity,
        height: 55,
        color: Theme.of(context).cardColor,
        child: Row(
          children: <Widget>[
            SizedBox(width: 9),
            Text(
              TerminalTexts.terminalInputPrefix,
              style: Theme.of(context).accentTextTheme.bodyText2,
            ),
            SizedBox(width: 9),
            Expanded(
              child: TerminalInputKeyboardListener(
                focusNode: _keyInputNode,
                onExecuteCommand: _onExecuteCommand,
                onNavigateHistoryBack: _navigateHistoryUp,
                onNavigateHistoryForward: _navigateHistoryDown,
                onAutocomplete: _tryToAutocomplete,
                child: TerminalInputTextField(
                  focusNode: _inputNode,
                  controller: _cmdTextController,
                  hintText: TerminalTexts.terminalInputHint,
                  onExecuteCommand: _onExecuteCommand,
                ),
              ),
            ),
            SizedBox(width: 9),
            FloatingActionButton(
              key: null,
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: _onExecuteCommand,
              mini: true,
              tooltip: TerminalTexts.executeCommandTooltip,
              child: Icon(Icons.play_arrow, color: Colors.white),
            ),
            SizedBox(width: 9),
          ],
        ),
      ),
    );
  }

  void _onExecuteCommand() {
    setState(() {
      FocusScope.of(context).unfocus();
      String commandLine = _cmdTextController.text;
      _cmdTextController.clear();
      context.read(terminalProvider.notifier).executeCommand(commandLine);
      _inputNode.requestFocus();
    });
  }

  void _navigateHistoryUp() {
    // final historyInput = context.read(terminalProvider.notifier).state.historyInput;
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
    String commandLine = _cmdTextController.text;
    context.read(terminalProvider.notifier).autocomplete(commandLine);
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _inputNode.requestFocus();
    });

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
    );
  }
}
