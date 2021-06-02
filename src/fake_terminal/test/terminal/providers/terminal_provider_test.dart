import 'package:fake_terminal/terminal/providers/terminal_provider.dart';
import 'package:fake_terminal/terminal/repositories/commands_repository/commands_repository.dart';
import 'package:fake_terminal/terminal/repositories/history_repository/history_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'terminal_provider_test.mocks.dart';

@GenerateMocks([HistoryRepository, CommandsRepository])
void main() {
  group('StateNotifierProvider', () {
    test('creation given the repositories are present', () {
      final historyRepository = MockHistoryRepository();
      final commandRepository = MockCommandsRepository();
      when(historyRepository.fetchTerminalHistory()).thenAnswer((_) async => null);
      final container = ProviderContainer(
        overrides: [
          historyRepositoryProvider.overrideWithProvider(Provider((ref) => historyRepository)),
          commandsRepositoryProvider.overrideWithProvider(Provider((ref) => commandRepository)),
        ],
      );
      final providerInstance = container.readProviderElement(terminalProvider).state.createdValue;
      expect(providerInstance, isA<TerminalNotifierImpl>());
    });

    test('creation fails given the history repository is not present', () {
      final commandRepository = MockCommandsRepository();
      final container = ProviderContainer(
        overrides: [
          historyRepositoryProvider.overrideWithProvider(Provider((ref) => throw Exception("This is an error"))),
          commandsRepositoryProvider.overrideWithProvider(Provider((ref) => commandRepository)),
        ],
      );
      var creationFailed = false;
      try {
        container.readProviderElement(terminalProvider).state.createdValue;
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });

    test('creation fails given the command repository is not present', () {
      final historyRepository = MockHistoryRepository();
      final container = ProviderContainer(
        overrides: [
          historyRepositoryProvider.overrideWithProvider(Provider((ref) => historyRepository)),
          commandsRepositoryProvider.overrideWithProvider(Provider((ref) => throw Exception("This is an error"))),
        ],
      );
      var creationFailed = false;
      try {
        container.readProviderElement(terminalProvider).state.createdValue;
        creationFailed = false;
      } catch (error) {
        creationFailed = true;
      }
      expect(creationFailed, true);
    });
  });
}
