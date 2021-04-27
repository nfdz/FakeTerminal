abstract class JavascriptDom {
  static JavascriptDom? instance;

  void navigateBack();
  bool canNavigateBack();
  String evalJs(String expression);
  bool canEvalJs();
}
