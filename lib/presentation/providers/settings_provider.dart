import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/domain/entities/settings.dart';
import 'package:pomodoro_app/domain/repositories/settings_repository.dart';
import 'package:pomodoro_app/presentation/providers/settings_dependencies.dart.dart';

// This provider manages the app's settings state, including durations for Pomodoro,
// short break, and long break sessions. It interacts with the
// SettingsRepository to load and save user preferences,
// ensuring that changes persist across app sessions.

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return SettingsNotifier(repo);
});

class SettingsNotifier extends StateNotifier<Settings> {
  final SettingsRepository _repository;

  SettingsNotifier(this._repository) : super(const Settings()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _repository.init();
      state = _repository.getSettings();
      if (kDebugMode) print('Settings loaded');
    } catch (e) {
      if (kDebugMode) print('Error loading settings: $e');
    }
  }

  Future<void> changePomodoroDuration(int minutes) async {
    try {
      final newState = state.copyWith(pomodoroDuration: minutes);
      state = newState;
      await _repository.setPomodoroDuration(minutes);
    } catch (_) {
      // invalid value — domain asserts will prevent incorrect state
    }
  }

  Future<void> changeShortBreakDuration(int minutes) async {
    try {
      final newState = state.copyWith(shortBreakDuration: minutes);
      state = newState;
      await _repository.setShortBreakDuration(minutes);
    } catch (_) {}
  }

  Future<void> changeLongBreakDuration(int minutes) async {
    try {
      final newState = state.copyWith(longBreakDuration: minutes);
      state = newState;
      await _repository.setLongBreakDuration(minutes);
    } catch (_) {}
  }
}
