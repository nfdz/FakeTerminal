import 'package:fake_terminal/terminal/repositories/commands_repository/commands/clear_command.dart';
import 'package:test/test.dart';

void main() {
  test('execute throw a ExecuteClearCommand exception', () async {
    expect(
      () async => await ClearCommand().execute(arguments: [], history: []),
      throwsA(TypeMatcher<ExecuteClearCommand>()),
    );
  });
  test('autocomplete return null', () async {
    expect(ClearCommand().autocomplete("argument"), null);
  });
}
