import 'package:fake_terminal/terminal/providers/terminal_provider.dart';
import 'package:fake_terminal/terminal/widgets/internal/terminal_entry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerminalOutputWidget extends ConsumerWidget {
  const TerminalOutputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final output = watch(terminalProvider).output.reversed.toList();
    return Scrollbar(
      child: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.fromLTRB(9, 0, 9, 9),
        itemCount: output.length,
        itemBuilder: (BuildContext context, int index) => TerminalEntryWidget(output[index]),
      ),
    );
  }
}
