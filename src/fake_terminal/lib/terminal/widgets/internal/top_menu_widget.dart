import 'package:fake_terminal/icons/terminal_icons.dart';
import 'package:fake_terminal/terminal/widgets/internal/information_dialog.dart';
import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';
import 'package:fake_terminal/theme/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class TopMenuWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          key: null,
          mini: true,
          onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
          tooltip: TerminalTexts.toggleThemeTooltip,
          child: Icon(
            theme == ThemeSettings.dark ? TerminalIcons.darkTheme : TerminalIcons.lightTheme,
          ),
        ),
        SizedBox(width: 5.sp),
        FloatingActionButton(
          key: null,
          mini: true,
          onPressed: () => _showMoreInfo(context),
          tooltip: TerminalTexts.infoTooltip,
          child: Icon(TerminalIcons.information),
        ),
      ],
    );
  }

  void _showMoreInfo(BuildContext context) {
    showDialog(context: context, builder: (context) => InformationDialog());
  }
}
