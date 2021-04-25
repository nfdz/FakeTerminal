import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:fake_terminal/theme/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class TopMenuWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = watch(themeProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          key: null,
          mini: true,
          onPressed: () => context.read(themeProvider.notifier).toggleTheme(),
          tooltip: TerminalTexts.toggleThemeTooltip,
          child: Icon(
            theme == ThemeSettings.dark ? Icons.nights_stay : Icons.wb_sunny,
          ),
        ),
        SizedBox(width: 4.sp),
        FloatingActionButton(
          key: null,
          mini: true,
          onPressed: () => _showMoreInfo(context),
          tooltip: TerminalTexts.infoTooltip,
          child: Icon(
            Icons.announcement,
          ),
        ),
      ],
    );
  }

  void _showMoreInfo(BuildContext context) {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       final double widthScreen = MediaQuery.of(context).size.width;
    //       final double width = Math.min(widthScreen, _kDialogMaxWidth);
    //       return AlertDialog(
    //         titlePadding: const EdgeInsets.all(0),
    //         contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
    //         content: Container(
    //           width: width,
    //           child: SingleChildScrollView(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.min,
    //               children: <Widget>[
    //                 Align(
    //                   alignment: Alignment.topRight,
    //                   child: InkWell(
    //                     highlightColor: Theme.of(context).accentColor,
    //                     onTap: () => Navigator.pop(context),
    //                     child: Icon(Icons.close),
    //                   ),
    //                 ),
    //                 Text(
    //                   kWarningDialogTitle,
    //                   style: Theme.of(context).textTheme.bodyText2,
    //                 ),
    //                 SizedBox(height: 9),
    //                 Text(
    //                   kWarningDialogContent,
    //                   style: Theme.of(context).textTheme.bodyText2,
    //                 ),
    //                 SizedBox(height: 6),
    //                 Align(
    //                   alignment: Alignment.bottomRight,
    //                   child: FlatButton(
    //                     highlightColor: Theme.of(context).accentColor,
    //                     onPressed: () => HtmlCommWorkAround.goGithub(),
    //                     child: Text(kWarningDialogGithub),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     });
  }
}
