import 'package:fake_terminal/plugins/javascript_dom/javascript_dom.dart';

abstract class ExitExecutor {
  bool hasExitCommand();
  void executeExitCommand();
}

class ExitExecutorImpl extends ExitExecutor {
  final JavascriptDom? _instance;
  ExitExecutorImpl(this._instance);

  @override
  bool hasExitCommand() {
    return _instance?.canNavigateBack() == true;
  }

  @override
  void executeExitCommand() {
    if (hasExitCommand()) {
      _instance?.navigateBack();
    }
  }
}
