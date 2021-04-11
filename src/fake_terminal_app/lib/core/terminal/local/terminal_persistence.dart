import 'dart:convert';

import 'package:fake_terminal_app/core/terminal/local/terminal_system.dart';
import 'package:fake_terminal_app/core/terminal/model/terminal_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TerminalPersistence {
  Future<TerminalHistory> fetchTerminalHistory();
  Future<void> saveTerminalHistory(TerminalHistory history);
}

class TerminalPersistencePreferences extends TerminalPersistence {
  static const _kHistoryKey = "history";

  @override
  Future<TerminalHistory> fetchTerminalHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_kHistoryKey);
    return historyJson != null ? TerminalHistory.fromJson(jsonDecode(historyJson)) : getDefaultTerminalFromSystem();
  }

  @override
  Future<void> saveTerminalHistory(TerminalHistory history) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kHistoryKey, jsonEncode(history.toJson()));
  }
}
