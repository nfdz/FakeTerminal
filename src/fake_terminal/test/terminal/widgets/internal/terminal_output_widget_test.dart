import 'package:fake_terminal/terminal/models/terminal_line.dart';
import 'package:fake_terminal/terminal/models/terminal_state.dart';
import 'package:fake_terminal/terminal/providers/terminal_provider.dart';
import 'package:fake_terminal/terminal/widgets/internal/terminal_entry_widget.dart';
import 'package:fake_terminal/terminal/widgets/internal/terminal_output_widget.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sizer/sizer.dart';

import '../../../mockito_extensions.dart';
import 'terminal_output_widget_test.mocks.dart';

@GenerateMocks([TerminalNotifier])
void main() {
  Widget _createWidgetToTest({
    TerminalNotifier? terminalNotifier,
  }) {
    return ProviderScope(
      overrides: [
        terminalProvider.overrideWith((ref) => terminalNotifier ?? MockTerminalNotifier()),
      ],
      child: Sizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            theme: ThemeSettings.dark.data(),
            home: Scaffold(
              body: TerminalOutputWidget(),
            ),
          );
        },
      ),
    );
  }

  testWidgets('given terminal state is empty then it shows no entries', (WidgetTester tester) async {
    final terminalState = TerminalState(output: [], historyInput: []);
    final terminalNotifier = MockTerminalNotifier();
    when(terminalNotifier.addListener(any)).thenAnswerStateToListener(terminalState);

    await tester.pumpWidget(_createWidgetToTest(
      terminalNotifier: terminalNotifier,
    ));

    expect(find.byType(TerminalEntryWidget), findsNothing);
  });

  testWidgets('given terminal state has one output entry then it shows one entry and it has the same line',
      (WidgetTester tester) async {
    final terminalLine = TerminalLine(line: "My line", type: LineType.command);
    final terminalState = TerminalState(output: [terminalLine], historyInput: []);
    final terminalNotifier = MockTerminalNotifier();
    when(terminalNotifier.addListener(any)).thenAnswerStateToListener(terminalState);

    await tester.pumpWidget(_createWidgetToTest(
      terminalNotifier: terminalNotifier,
    ));

    expect(find.byType(TerminalEntryWidget), findsOneWidget);
    final entryWidget = tester.widget<TerminalEntryWidget>(find.byType(TerminalEntryWidget));
    expect(entryWidget.entry, terminalLine);
  });

  testWidgets(
      'given terminal state has 20 output entries then it shows 20 entries and the lines matches in reverse order',
      (WidgetTester tester) async {
    final entries = List.generate(20, (i) => TerminalLine(line: "My line $i", type: LineType.command));
    final terminalState = TerminalState(output: entries, historyInput: []);
    final terminalNotifier = MockTerminalNotifier();
    when(terminalNotifier.addListener(any)).thenAnswerStateToListener(terminalState);

    await tester.pumpWidget(_createWidgetToTest(
      terminalNotifier: terminalNotifier,
    ));

    expect(find.byType(TerminalEntryWidget), findsNWidgets(20));
    final entriesFromWidgets =
        tester.widgetList<TerminalEntryWidget>(find.byType(TerminalEntryWidget)).map((e) => e.entry);
    expect(entriesFromWidgets, entries.reversed);
  });
}
