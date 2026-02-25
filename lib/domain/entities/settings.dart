/// Domain entity representing user-configurable timer settings.
///
/// This entity enforces its invariants at construction time,
/// ensuring that all durations remain within allowed ranges.
///
/// It is immutable and provides value-based state updates via `copyWith`.
/// No persistence or UI concerns are handled here.
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
