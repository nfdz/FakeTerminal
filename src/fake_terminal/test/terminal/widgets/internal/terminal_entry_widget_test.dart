import 'package:fake_terminal/terminal/models/terminal_line.dart';
import 'package:fake_terminal/terminal/widgets/internal/terminal_entry_widget.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sizer/sizer.dart';

void main() {
  Future<void> _testLineStyle(
    WidgetTester tester,
    LineType type,
    TextStyle Function(BuildContext) getStyle,
  ) async {
    final line = "This is my line";
    final themeSettings = ThemeSettings.dark;
    TextStyle? expectedStyle;
    await tester.pumpWidget(Sizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        theme: themeSettings.data(),
        home: Builder(builder: (context) {
          expectedStyle = getStyle(context);
          return TerminalEntryWidget(
            TerminalLine(
              line: line,
              type: type,
              prefix: null,
            ),
          );
        }),
      );
    }));

    final text = tester.widget<Text>(find.text(line));
    expect(text.style, expectedStyle);
  }

  testWidgets('given line without prefix of type result then use the expected style', (WidgetTester tester) async {
    await _testLineStyle(tester, LineType.result, (context) => Theme.of(context).textTheme.bodyText1!);
  });
  testWidgets('given line without prefix of type command then use the expected style', (WidgetTester tester) async {
    await _testLineStyle(tester, LineType.command, (context) => Theme.of(context).textTheme.bodyText2!);
  });
  testWidgets('given line without prefix of type timestamp then use the expected style', (WidgetTester tester) async {
    await _testLineStyle(tester, LineType.timestamp, (context) => Theme.of(context).textTheme.bodyText1!);
  });

  Future<void> _testPrefixStyle(
    WidgetTester tester,
    LineType type,
    TextStyle Function(BuildContext) getStyle,
  ) async {
    final prefix = "This is my prefix";
    final themeSettings = ThemeSettings.dark;
    TextStyle? expectedStyle;
    await tester.pumpWidget(Sizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        theme: themeSettings.data(),
        home: Builder(builder: (context) {
          expectedStyle = getStyle(context);
          return TerminalEntryWidget(
            TerminalLine(
              line: "",
              type: type,
              prefix: prefix,
            ),
          );
        }),
      );
    }));

    final richText = tester.widget<RichText>(find.byKey(TerminalEntryWidget.prefixKey));
    expect(richText.text.style, expectedStyle);
  }

  testWidgets('given line with prefix of type result then the prefix use the expected style',
      (WidgetTester tester) async {
    await _testPrefixStyle(tester, LineType.result, (context) => Theme.of(context).accentTextTheme.bodyText2!);
  });

  testWidgets('given line with prefix of type command then the prefix use the expected style',
      (WidgetTester tester) async {
    await _testPrefixStyle(tester, LineType.command, (context) => Theme.of(context).accentTextTheme.bodyText2!);
  });

  testWidgets('given line with prefix of type timestamp then the prefix use the expected style',
      (WidgetTester tester) async {
    await _testPrefixStyle(tester, LineType.timestamp, (context) => Theme.of(context).accentTextTheme.bodyText2!);
  });
}
