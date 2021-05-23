import 'package:fake_terminal/plugins/javascript_dom/javascript_dom.dart';

abstract class JavascriptExecutor {
  String execute(String expression);
}

class JavascriptExecutorImpl extends JavascriptExecutor {
  final JavascriptDom _instance;
  JavascriptExecutorImpl(this._instance);

  @override
  String execute(String expression) {
    return _instance.evalJs(expression);
  }
}
