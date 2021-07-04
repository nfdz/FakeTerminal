import 'package:fake_terminal/terminal/repositories/commands_repository/commands/exit_command.dart';
import 'package:test/test.dart';

void main() {
  test('execute invoke exit callback and return nothing', () async {
    int exitCounter = 0;
    final command = ExitCommand(() {
      exitCounter++;
    });
    expect(await command.execute(arguments: [], history: []), []);
    expect(exitCounter, 1);
  });
  test('autocomplete return null', () async {
    expect(ExitCommand(() {}).autocomplete("argument"), null);
  });
}
