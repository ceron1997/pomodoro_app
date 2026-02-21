// This file defines the Pomodoro entity, which represents the state of the Pomodoro timer,
// including the total duration, remaining time, whether the timer is running, and the type of
// session (Pomodoro, short break, or long break). The Pomodoro class includes methods to
// calculate the progress of the timer and format the remaining time for display in the UI.
// This entity is used by the TimerNotifier to manage the state of the timer
// and update the UI accordingly.

enum SessionType {
  pomodoro,
  shortBreak,
  longBreak,
}

class Pomodoro {
  final int totalSeconds;
  final int remainingSeconds;
  final bool isRunning;
  final SessionType sessionType;

  const Pomodoro({
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.isRunning,
    required this.sessionType,
  });

  double get progress => 1 - (remainingSeconds / totalSeconds);

  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  Pomodoro copyWith({
    int? totalSeconds,
    int? remainingSeconds,
    bool? isRunning,
    SessionType? sessionType,
  }) {
    return Pomodoro(
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
      sessionType: sessionType ?? this.sessionType,
    );
  }
}
