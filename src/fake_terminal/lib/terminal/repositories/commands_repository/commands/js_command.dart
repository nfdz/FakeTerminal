import 'package:fake_terminal/plugins/javascript_dom/javascript_dom.dart';
import 'package:fake_terminal/terminal/models/terminal_command.dart';

class JsCommand extends TerminalCommand {
  JsCommand()
      : super(
          name: _kCommandName,
          description: _kCommandDescription,
          manual: _kCommandManual,
        );

  @override
  Future<List<String>> execute({required List<String> arguments, required List<String> history}) async {
    if (arguments.isEmpty) {
      return [_kCommandInvalid];
    }
    final linesToEval = _getLinesToEval(arguments);
    final List<String> output = [];
    for (final lineToEval in linesToEval) {
      try {
        output.add("> $lineToEval");
        output.add(JavascriptDom.instance?.evalJs(lineToEval) ?? "");
      } catch (e) {
        output.add(e.toString());
      }
    }
    return output;
  }

  List<String> _getLinesToEval(List<String> arguments) {
    final allLinesToEval = arguments.fold<String>("", (previousValue, element) => previousValue + element);
    return allLinesToEval.split(";").where((e) => e.isNotEmpty).map((e) => e.trim() + ";").toList();
  }

  @override
  String? autocomplete(String argument) {
    return null;
  }
}

const String _kCommandName = "js";
const String _kCommandDescription = "Run the provided JavaScript code";
const String _kCommandManual = """
HISTORY(1)

NAME
       js - run the provided JavaScript code

SYNOPSIS
       js [CODE]

DESCRIPTION
       Evaluate and run the provided code. The JavaScript engine maintains the state from one execution to another.

EXAMPLES
       js a = 1; a++; a;""";
const String _kCommandInvalid = "Input argument required, to learn about this command use: man js";
