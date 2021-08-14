import 'package:fake_terminal/icons/terminal_icons.dart';
import 'package:fake_terminal/sizer/sizer_extensions.dart';
import 'package:fake_terminal/terminal/providers/terminal_provider.dart';
import 'package:fake_terminal/terminal/widgets/internal/terminal_input_keyboard_listener.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class TerminalInputWidget extends StatefulWidget {
  final FocusNode? inputNode;
  final FocusNode? keyboardInputNode;

  TerminalInputWidget({
    this.inputNode,
    this.keyboardInputNode,
  });

  @override
  _TerminalInputWidgetState createState() => _TerminalInputWidgetState();
}

class _TerminalInputWidgetState extends State<TerminalInputWidget> {
  TextEditingController _cmdTextController = TextEditingController();
  late final FocusNode _inputNode;
  late final FocusNode _keyInputNode;

  @override
  void initState() {
    super.initState();
    _inputNode = widget.inputNode ?? FocusNode();
    _keyInputNode = widget.keyboardInputNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = 4.sp.withMaxValue(9.5);
    return Container(
      width: double.infinity,
      height: 25.sp.withMaxValue(60),
      color: Theme.of(context).cardColor,
      child: Row(
        children: <Widget>[
          SizedBox(width: spacing),
          Text(
            TerminalTexts.terminalInputPrefix,
            style: Theme.of(context).accentTextTheme.bodyText2,
          ),
          SizedBox(width: spacing),
          Expanded(
            child: TerminalInputKeyboardListener(
              focusNode: _keyInputNode,
              onExecuteCommand: _onExecuteCommand,
              onNavigateHistoryBack: () => _processInput(context.read(terminalProvider.notifier).navigateHistoryBack),
              onNavigateHistoryForward: () =>
                  _processInput(context.read(terminalProvider.notifier).navigateHistoryForward),
              onAutocomplete: () => _processInput(context.read(terminalProvider.notifier).autocomplete),
              child: TerminalInputTextField(
                focusNode: _inputNode,
                controller: _cmdTextController,
                hintText: TerminalTexts.terminalInputHint,
                onExecuteCommand: _onExecuteCommand,
              ),
            ),
          ),
          SizedBox(width: spacing),
          Padding(
            padding: EdgeInsets.symmetric(vertical: spacing),
            child: FloatingActionButton(
              key: null,
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).primaryColor,
              onPressed: _onExecuteCommand,
              mini: true,
              tooltip: TerminalTexts.executeCommandTooltip,
              child: Icon(
                TerminalIcons.executeCommand,
                color: Theme.of(context).textTheme.bodyText1?.color,
                size: 10.sp.withMaxValue(25),
              ),
            ),
          ),
          SizedBox(width: spacing),
        ],
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

  void _processInput(String? Function(String) process) {
    FocusScope.of(context).unfocus();
    String commandLine = _cmdTextController.text;
    final result = process(commandLine);
    if (result != null) {
      setState(() {
        _cmdTextController.text = result;
      });
    }
    _inputNode.requestFocus();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _inputNode.requestFocus();
      _cmdTextController.selection = TextSelection.fromPosition(TextPosition(offset: _cmdTextController.text.length));
    });
  }
}

class TerminalInputTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final Function onExecuteCommand;

  TerminalInputTextField({
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
      autocorrect: false,
      controller: this.controller,
      enableSuggestions: false,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: this.hintText,
        isCollapsed: true,
        contentPadding: EdgeInsets.zero,
      ),
      onEditingComplete: () => this.onExecuteCommand(),
    );
  }
}
