import 'package:fake_terminal/icons/terminal_icons.dart';
import 'package:fake_terminal/terminal/widgets/internal/information_dialog.dart';
import 'package:fake_terminal/terminal/widgets/internal/top_menu_widget.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:fake_terminal/theme/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sizer/sizer.dart';

import '../../../mockito_extensions.dart';
import 'top_menu_widget_test.mocks.dart';

@GenerateMocks([ThemeNotifier])
void main() {
  Widget _createWidgetToTest({
    ThemeNotifier? themeNotifier,
  }) {
    return ProviderScope(
      overrides: [
        themeProvider.overrideWithProvider(StateNotifierProvider((ref) => themeNotifier ?? MockThemeNotifier())),
      ],
      child: Sizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            theme: ThemeSettings.dark.data(),
            home: Scaffold(
              body: TopMenuWidget(),
            ),
          );
        },
      ),
    );
  }

  group('toggle theme icon', () {
    testWidgets('given theme is dark then show dark theme icon', (WidgetTester tester) async {
      final themeNotifier = MockThemeNotifier();
      when(themeNotifier.addListener(any)).thenAnswerStateToListener(ThemeSettings.dark);

      await tester.pumpWidget(_createWidgetToTest(
        themeNotifier: themeNotifier,
      ));

      expect(find.byIcon(TerminalIcons.darkTheme), findsOneWidget);
      expect(find.byIcon(TerminalIcons.lightTheme), findsNothing);
    });
    testWidgets('given theme is light then show light theme icon', (WidgetTester tester) async {
      final themeNotifier = MockThemeNotifier();
      when(themeNotifier.addListener(any)).thenAnswerStateToListener(ThemeSettings.light);

      await tester.pumpWidget(_createWidgetToTest(
        themeNotifier: themeNotifier,
      ));

      expect(find.byIcon(TerminalIcons.lightTheme), findsOneWidget);
      expect(find.byIcon(TerminalIcons.darkTheme), findsNothing);
    });
    testWidgets('given user tap theme icon then invoke toggleTheme', (WidgetTester tester) async {
      final themeNotifier = MockThemeNotifier();
      when(themeNotifier.addListener(any)).thenAnswerStateToListener(ThemeSettings.dark);
      when(themeNotifier.toggleTheme()).thenReturn(null);

      await tester.pumpWidget(_createWidgetToTest(
        themeNotifier: themeNotifier,
      ));

      await tester.tap(find.byIcon(TerminalIcons.darkTheme));

      verify(themeNotifier.toggleTheme()).called(1);
    });
  });

  testWidgets('information icon have tooltip', (WidgetTester tester) async {
    final themeNotifier = MockThemeNotifier();
    when(themeNotifier.addListener(any)).thenAnswerStateToListener(ThemeSettings.dark);

    await tester.pumpWidget(_createWidgetToTest(
      themeNotifier: themeNotifier,
    ));

    final infoIconFinder = find.ancestor(
      of: find.byIcon(TerminalIcons.information),
      matching: find.byType(FloatingActionButton),
    );
    expect(infoIconFinder, findsOneWidget);
    final infoIconWidget = tester.widget<FloatingActionButton>(infoIconFinder);
    expect(infoIconWidget.tooltip, TerminalTexts.infoTooltip);
  });

  testWidgets('given user tap information icon then show a dialog with information', (WidgetTester tester) async {
    final themeNotifier = MockThemeNotifier();
    when(themeNotifier.addListener(any)).thenAnswerStateToListener(ThemeSettings.dark);

    await tester.pumpWidget(_createWidgetToTest(
      themeNotifier: themeNotifier,
    ));

    await tester.tap(find.byIcon(TerminalIcons.information));
    await tester.pumpAndSettle();

    expect(find.byType(InformationDialog), findsOneWidget);
  });
}
