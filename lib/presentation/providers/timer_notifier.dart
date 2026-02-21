import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/presentation/providers/settings_provider.dart';
import 'package:pomodoro_app/domain/entities/pomodoro.dart';
import 'package:pomodoro_app/domain/services/notification_service.dart';
import 'package:pomodoro_app/presentation/providers/notification_provider.dart';

// Este archivo define el `PomodoroNotifier`, que gestiona el estado del temporizador Pomodoro,
// incluyendo la lógica para iniciar, pausar, reiniciar y
// cambiar entre sesiones de trabajo y descanso.

const sessionPomodoro = SessionType.pomodoro;
const sessionShortBreak = SessionType.shortBreak;
const sessionLongBreak = SessionType.longBreak;

const Map<SessionType, String> sessionLabels = {
  sessionPomodoro: 'Pomodoro',
  sessionShortBreak: 'Pausa corta',
  sessionLongBreak: 'Pausa larga',
};

const Map<SessionType, IconData> sessionIcons = {
  sessionPomodoro: Icons.work_history,
  sessionShortBreak: Icons.coffee,
  sessionLongBreak: Icons.coffee_maker,
};

// Domain entity `Pomodoro` moved to `lib/domain/entities/pomodoro.dart`

class PomodoroNotifier extends Notifier<Pomodoro> {
  Timer? _timer;
  NotificationService get _notificationService =>
      ref.read(notificationServiceProvider);

  @override
  Pomodoro build() {
    final settings = ref.read(settingsProvider);

    final seconds = settings.pomodoroDuration * 60;

    ref.listen(settingsProvider, (previous, next) {
      if (state.isRunning) return;

      int newSeconds;

      switch (state.sessionType) {
        case sessionShortBreak:
          newSeconds = next.shortBreakDuration * 60;
          break;
        case sessionLongBreak:
          newSeconds = next.longBreakDuration * 60;
          break;
        default:
          newSeconds = next.pomodoroDuration * 60;
      }

      state = state.copyWith(
        totalSeconds: newSeconds,
        remainingSeconds: newSeconds,
      );
    });

    return Pomodoro(
      totalSeconds: seconds,
      remainingSeconds: seconds,
      isRunning: false,
      sessionType: sessionPomodoro,
    );
  }

  void start() {
    if (state.isRunning) return;

    state = state.copyWith(isRunning: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final seconds = state.remainingSeconds - 1;

      if (seconds <= 0) {
        timer.cancel();

        // Reproducir sonido al finalizar (a través de la abstracción)
        _notificationService.playDing();

        state = state.copyWith(
          isRunning: false,
          remainingSeconds: 0,
        );
        return;
      }

      state = state.copyWith(remainingSeconds: seconds);
    });
  }

  void pause() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  void reset() {
    _timer?.cancel();
    state = state.copyWith(
      remainingSeconds: state.totalSeconds,
      isRunning: false,
    );
  }

  void setSession(SessionType type) {
    final settings = ref.read(settingsProvider);
    int seconds;

    switch (type) {
      case sessionShortBreak:
        seconds = settings.shortBreakDuration * 60;
        break;
      case sessionLongBreak:
        seconds = settings.longBreakDuration * 60;
        break;
      default:
        seconds = settings.pomodoroDuration * 60;
    }

    _timer?.cancel(); // detener si está corriendo

    state = state.copyWith(
      sessionType: type,
      totalSeconds: seconds,
      remainingSeconds: seconds,
      isRunning: false,
    );
  }
}

final pomodoroProvider =
    NotifierProvider<PomodoroNotifier, Pomodoro>(PomodoroNotifier.new);
