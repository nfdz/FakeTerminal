import 'dart:convert';

import 'package:fake_terminal/terminal/models/terminal_history.dart';
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final historyRepositoryProvider =
    Provider<HistoryRepository>((ref) => HistoryRepositoryImpl(SharedPreferences.getInstance()));

abstract class HistoryRepository {
  Future<TerminalHistory?> fetchTerminalHistory();
  Future<void> saveTerminalHistory(TerminalHistory history);
}

final Logger _kLogger = Logger("HistoryRepository");

class HistoryRepositoryImpl extends HistoryRepository {
  static const kHistoryKey = "history";

  final Future<SharedPreferences> _sharedPreferences;
  HistoryRepositoryImpl(this._sharedPreferences);

  @override
  Future<TerminalHistory?> fetchTerminalHistory() async {
    try {
      SharedPreferences prefs = await _sharedPreferences;
      final historyJson = prefs.getString(kHistoryKey);
      return historyJson != null ? TerminalHistory.fromJson(jsonDecode(historyJson)) : null;
    } catch (error) {
      _kLogger.warning("Cannot load history", error);
      return null;
    }
  }

  @override
  Future<void> saveTerminalHistory(TerminalHistory history) async {
    try {
      SharedPreferences prefs = await _sharedPreferences;
      await prefs.setString(kHistoryKey, jsonEncode(history.toJson()));
    } catch (error) {
      _kLogger.warning("Cannot save history", error);
      return null;
    }
  }
}
