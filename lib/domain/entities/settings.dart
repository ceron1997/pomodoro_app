// This file defines the Settings entity, which represents the user's preferences for the Pomodoro
// timer, including durations for Pomodoro sessions, short breaks, and long breaks. The
// Settings class includes validation to ensure that the durations are within
// reasonable limits, and a copyWith method to facilitate state updates in the
// SettingsProvider. This entity is used throughout the app to manage and persist user settings.

class Settings {
  final int pomodoroDuration;
  final int shortBreakDuration;
  final int longBreakDuration;

  const Settings({
    this.pomodoroDuration = 25,
    this.shortBreakDuration = 5,
    this.longBreakDuration = 15,
  })  : assert(pomodoroDuration >= 25 && pomodoroDuration <= 60,
            "La duración del pomodoro debe estar entre 25 y 60 minutos"),
        assert(shortBreakDuration >= 5 && shortBreakDuration <= 10,
            "La duración del descanso corto debe estar entre 5 y 10 minutos"),
        assert(longBreakDuration >= 11 && longBreakDuration <= 20,
            "La duración del descanso largo debe estar entre 11 y 20 minutos");

  Settings copyWith({
    int? pomodoroDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
  }) {
    return Settings(
      pomodoroDuration: pomodoroDuration ?? this.pomodoroDuration,
      shortBreakDuration: shortBreakDuration ?? this.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? this.longBreakDuration,
    );
  }
}
