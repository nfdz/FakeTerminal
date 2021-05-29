import 'dart:convert';

import 'package:fake_terminal/terminal/models/terminal_history.dart';
import 'package:fake_terminal/terminal/models/terminal_line.dart';
import 'package:fake_terminal/terminal/repositories/history_repository/history_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'history_repository_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('fetchTerminalHistory', () {
    test('given SharedPreferences is empty then return null', () async {
      final preferences = MockSharedPreferences();
      when(preferences.getString(any)).thenReturn(null);

      final repository = HistoryRepositoryImpl(Future.value(preferences));
      final result = await repository.fetchTerminalHistory();

      expect(result, null);
      verify(preferences.getString(HistoryRepositoryImpl.kHistoryKey)).called(1);
    });

    test('given SharedPreferences failed then return null', () async {
      final preferences = MockSharedPreferences();
      when(preferences.getString(any)).thenThrow(Exception("This is an error"));

      final repository = HistoryRepositoryImpl(Future.value(preferences));
      final result = await repository.fetchTerminalHistory();

      expect(result, null);
      verify(preferences.getString(HistoryRepositoryImpl.kHistoryKey)).called(1);
    });

    test('given SharedPreferences contain data then return the expected data', () async {
      final expectedHistory = TerminalHistory(
        output: [
          TerminalLine(line: "line1", type: LineType.command),
          TerminalLine(line: "line2", type: LineType.result),
        ],
        historyInput: ["history1", "history2"],
        timestampMillis: 123,
      );

      final preferences = MockSharedPreferences();
      when(preferences.getString(any)).thenReturn(jsonEncode(expectedHistory.toJson()));

      final repository = HistoryRepositoryImpl(Future.value(preferences));
      final result = await repository.fetchTerminalHistory();

      expect(result, expectedHistory);
      verify(preferences.getString(HistoryRepositoryImpl.kHistoryKey)).called(1);
    });
  });

  group('saveTerminalHistory', () {
    test('given TerminalHistory then invoke SharedPreferences.setString with valid data', () async {
      final historyToSave = TerminalHistory(
        output: [
          TerminalLine(line: "line1", type: LineType.command),
          TerminalLine(line: "line2", type: LineType.result),
        ],
        historyInput: ["history1", "history2"],
        timestampMillis: 123,
      );

      final preferences = MockSharedPreferences();
      when(preferences.setString(any, any)).thenAnswer((_) async => true);

      final repository = HistoryRepositoryImpl(Future.value(preferences));
      await repository.saveTerminalHistory(historyToSave);

      final expectedJson = jsonEncode(historyToSave.toJson());
      verify(preferences.setString(HistoryRepositoryImpl.kHistoryKey, expectedJson)).called(1);
    });

    test('given SharedPreferences.setString failed then do not crash', () async {
      final historyToSave = TerminalHistory(
        output: [],
        historyInput: [],
        timestampMillis: 123,
      );

      final preferences = MockSharedPreferences();
      when(preferences.setString(any, any)).thenThrow(Exception("This is an error"));

      final repository = HistoryRepositoryImpl(Future.value(preferences));
      await repository.saveTerminalHistory(historyToSave);

      final expectedJson = jsonEncode(historyToSave.toJson());
      verify(preferences.setString(HistoryRepositoryImpl.kHistoryKey, expectedJson)).called(1);
    });
  });
}
