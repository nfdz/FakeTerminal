import 'dart:convert';

import 'package:fake_terminal/terminal/models/terminal_history.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final historyRepositoryProvider = Provider<HistoryRepository>((ref) => _HistoryRepositoryPreferences());

abstract class HistoryRepository {
  Future<TerminalHistory?> fetchTerminalHistory();
  Future<void> saveTerminalHistory(TerminalHistory history);
}

class _HistoryRepositoryPreferences extends HistoryRepository {
  static const _kHistoryKey = "history";

  @override
  Future<TerminalHistory?> fetchTerminalHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_kHistoryKey);
    return historyJson != null ? TerminalHistory.fromJson(jsonDecode(historyJson)) : null;
  }

  @override
  Future<void> saveTerminalHistory(TerminalHistory history) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kHistoryKey, jsonEncode(history.toJson()));
  }
}
