import 'package:pomodoro_app/domain/entities/settings.dart';
import 'package:pomodoro_app/domain/repositories/settings_repository.dart';
import 'package:pomodoro_app/infrastructure/local_storage/preferences_service.dart';

// This file implements the PreferencesSettingsRepository, which is a concrete implementation
// of the SettingsRepository interface. It uses the PreferencesService to persist user settings

class PreferencesSettingsRepository implements SettingsRepository {
  final PreferencesService _prefs;
  PreferencesSettingsRepository(this._prefs);

  @override
  Future<void> init() async {
    await _prefs.init();
  }

  @override
  Settings getSettings() {
    return Settings(
      pomodoroDuration: _prefs.getPomodoroDuration(),
      shortBreakDuration: _prefs.getShortBreakDuration(),
      longBreakDuration: _prefs.getLongBreakDuration(),
    );
  }

  @override
  Future<void> setPomodoroDuration(int minutes) async {
    await _prefs.setPomodoroDuration(minutes);
  }

  @override
  Future<void> setShortBreakDuration(int minutes) async {
    await _prefs.setShortBreakDuration(minutes);
  }

  @override
  Future<void> setLongBreakDuration(int minutes) async {
    await _prefs.setLongBreakDuration(minutes);
  }
}
