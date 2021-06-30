// Mocks generated by Mockito 5.0.7 from annotations
// in fake_terminal/test/terminal/widgets/internal/terminal_output_widget_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:fake_terminal/terminal/models/terminal_state.dart' as _i2;
import 'package:fake_terminal/terminal/providers/terminal_provider.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:state_notifier/state_notifier.dart' as _i4;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeTerminalState extends _i1.Fake implements _i2.TerminalState {}

/// A class which mocks [TerminalNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTerminalNotifier extends _i1.Mock implements _i3.TerminalNotifier {
  MockTerminalNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set onError(_i4.ErrorListener? _onError) =>
      super.noSuchMethod(Invocation.setter(#onError, _onError),
          returnValueForMissingStub: null);
  @override
  bool get mounted =>
      (super.noSuchMethod(Invocation.getter(#mounted), returnValue: false)
          as bool);
  @override
  _i5.Stream<_i2.TerminalState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.TerminalState>.empty())
          as _i5.Stream<_i2.TerminalState>);
  @override
  _i2.TerminalState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeTerminalState()) as _i2.TerminalState);
  @override
  set state(_i2.TerminalState? value) =>
      super.noSuchMethod(Invocation.setter(#state, value),
          returnValueForMissingStub: null);
  @override
  _i2.TerminalState get debugState =>
      (super.noSuchMethod(Invocation.getter(#debugState),
          returnValue: _FakeTerminalState()) as _i2.TerminalState);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  bool canExitTerminal() =>
      (super.noSuchMethod(Invocation.method(#canExitTerminal, []),
          returnValue: false) as bool);
  @override
  void exitTerminal() =>
      super.noSuchMethod(Invocation.method(#exitTerminal, []),
          returnValueForMissingStub: null);
  @override
  void navigateToRepository() =>
      super.noSuchMethod(Invocation.method(#navigateToRepository, []),
          returnValueForMissingStub: null);
  @override
  void executeCommand(String? commandLine) =>
      super.noSuchMethod(Invocation.method(#executeCommand, [commandLine]),
          returnValueForMissingStub: null);
  @override
  String? autocomplete(String? commandLine) =>
      (super.noSuchMethod(Invocation.method(#autocomplete, [commandLine]))
          as String?);
  @override
  String? navigateHistoryBack(String? commandLine) => (super
          .noSuchMethod(Invocation.method(#navigateHistoryBack, [commandLine]))
      as String?);
  @override
  String? navigateHistoryForward(String? commandLine) => (super.noSuchMethod(
      Invocation.method(#navigateHistoryForward, [commandLine])) as String?);
  @override
  _i4.RemoveListener addListener(_i4.Listener<_i2.TerminalState>? listener,
          {bool? fireImmediately = true}) =>
      (super.noSuchMethod(
          Invocation.method(
              #addListener, [listener], {#fireImmediately: fireImmediately}),
          returnValue: () {}) as _i4.RemoveListener);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
}
