import 'package:pomodoro_app/domain/entities/settings.dart';

// This file defines the SettingsRepository interface, which abstracts the
// data layer for managing user settings in the app. By defining this as an interface,
// we can easily swap out different
// implementations (e.g., local storage, remote database) without affecting the
// rest of the app's codebase. The SettingsRepository provides methods
// to initialize the repository, retrieve current settings,
// and update individual settings such as Pomodoro duration and break durations.

abstract class SettingsRepository {
  Future<void> init();
  Settings getSettings();

// Could be refactored to use saveSettings(Settings settings)
  Future<void> setPomodoroDuration(int minutes);
  Future<void> setShortBreakDuration(int minutes);
  Future<void> setLongBreakDuration(int minutes);
}
