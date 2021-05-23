import 'dart:html' as html;
import 'dart:js' as js;

import 'package:fake_terminal/plugins/javascript_dom/javascript_dom.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class JavascriptDomPlugin extends JavascriptDom {
  static void registerWith(Registrar? registrar) {
    JavascriptDom.instance = JavascriptDomPlugin();
  }

  @override
  bool canNavigateBack() {
    return html.window.history.length > 1;
  }

  @override
  void navigateBack() {
    return html.window.history.back();
  }

  @override
  String evalJs(String expression) {
    return js.context.callMethod("eval", [expression]).toString();
  }
}
