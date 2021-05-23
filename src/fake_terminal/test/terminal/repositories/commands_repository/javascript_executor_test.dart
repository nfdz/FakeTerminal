import 'package:fake_terminal/plugins/javascript_dom/javascript_dom.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/javascript_executor.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'javascript_executor_test.mocks.dart';

@GenerateMocks([JavascriptDom])
void main() {
  group('execute', () {
    test('given JavascriptDom then invoke evalJs and return its output', () async {
      final expectedValue = "myJsOutput";
      final javascriptDom = MockJavascriptDom();
      when(javascriptDom.evalJs(any)).thenReturn(expectedValue);

      final jsExecutor = JavascriptExecutorImpl(javascriptDom);

      final jsToEval = "myJsCode";
      expect(jsExecutor.execute(jsToEval), expectedValue);

      verify(javascriptDom.evalJs(jsToEval)).called(1);
    });
  });
}
