import 'package:fake_terminal/plugins/javascript_dom/javascript_dom.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/exit_executor.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'exit_executor_test.mocks.dart';

@GenerateMocks([JavascriptDom])
void main() {
  group('hasExitCommand', () {
    test('given JavascriptDom null then return false', () async {
      final exitExecutor = ExitExecutorImpl(null);
      expect(exitExecutor.hasExitCommand(), false);
    });

    test('given JavascriptDom is present then invoke and return its output', () async {
      final expectedValue = true;
      final javascriptDom = MockJavascriptDom();
      when(javascriptDom.canNavigateBack()).thenReturn(expectedValue);

      final exitExecutor = ExitExecutorImpl(javascriptDom);

      expect(exitExecutor.hasExitCommand(), expectedValue);
      verify(javascriptDom.canNavigateBack()).called(1);
    });
  });

  group('executeExitCommand', () {
    test('given JavascriptDom null then do nothing', () async {
      final exitExecutor = ExitExecutorImpl(null);
      exitExecutor.executeExitCommand();
    });

    test('given JavascriptDom is present and canNavigateBack false then do not invoke navigateBack', () async {
      final javascriptDom = MockJavascriptDom();
      when(javascriptDom.canNavigateBack()).thenReturn(false);
      when(javascriptDom.navigateBack()).thenReturn(null);

      final exitExecutor = ExitExecutorImpl(javascriptDom);
      exitExecutor.executeExitCommand();

      verifyNever(javascriptDom.navigateBack());
    });

    test('given JavascriptDom is present and canNavigateBack true then do invoke navigateBack', () async {
      final javascriptDom = MockJavascriptDom();
      when(javascriptDom.canNavigateBack()).thenReturn(true);
      when(javascriptDom.navigateBack()).thenReturn(null);

      final exitExecutor = ExitExecutorImpl(javascriptDom);
      exitExecutor.executeExitCommand();

      verify(javascriptDom.navigateBack()).called(1);
    });
  });
}
