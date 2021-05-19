import 'package:fake_terminal/plugins/javascript_dom/javascript_dom.dart';

abstract class ExitExecutor {
  bool hasExitCommand();
  void executeExitCommand();
}

class ExitExecutorJavascript extends ExitExecutor {
  @override
  bool hasExitCommand() {
    return JavascriptDom.instance?.canNavigateBack() == true;
  }

  @override
  void executeExitCommand() {
    if (hasExitCommand()) {
      JavascriptDom.instance?.navigateBack();
    }
  }
}
