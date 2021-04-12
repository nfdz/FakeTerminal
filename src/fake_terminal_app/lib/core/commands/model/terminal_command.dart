abstract class TerminalCommand {
  final String name;
  final String manual;
  TerminalCommand({required this.name, required this.manual});

  List<String> execute(List<String> arguments);
  String? autocomplete(String argument);
}
