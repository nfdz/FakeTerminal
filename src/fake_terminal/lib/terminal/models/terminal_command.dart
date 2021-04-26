abstract class TerminalCommand {
  final String name;
  final String description;
  final String manual;
  TerminalCommand({
    required this.name,
    required this.description,
    required this.manual,
  });

  Future<List<String>> execute({required List<String> arguments, required List<String> history});
  String? autocomplete(String argument);
}
