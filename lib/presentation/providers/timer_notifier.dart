import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:pomodoro_app/presentation/services/sound_service.dart';
import 'package:riverpod/riverpod.dart';

const SessionPomodoro = 'pomodoro';
const SessionShortBreak = 'short_break';
const SessionLongBreak = 'long_break';

const Map<String, String> sessionLabels = {
  SessionPomodoro: 'Pomodoro',
  SessionShortBreak: 'Pausa corta',
  SessionLongBreak: 'Pausa larga',
};

const Map<String, IconData> sessionIcons = {
  SessionPomodoro: Icons.work_history,
  SessionShortBreak: Icons.coffee,
  SessionLongBreak: Icons.coffee_maker,
};

class PomodoroState {
  final int totalSeconds; // ex: 25 * 60
  final int remainingSeconds; // segundos restantes
  final bool isRunning;
  final String sessionType; // "Pomodoro" | "Short Break" | "Long Break"

  const PomodoroState({
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

  PomodoroState copyWith({
    int? totalSeconds,
    int? remainingSeconds,
    bool? isRunning,
    String? sessionType,
  }) {
    return PomodoroState(
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
      sessionType: sessionType ?? this.sessionType,
    );
  }
}

class PomodoroNotifier extends Notifier<PomodoroState> {
  Timer? _timer;
  late final SoundService _soundService;

  @override
  PomodoroState build() {
    // Obtener el servicio aquí
    _soundService = ref.read(soundServiceProvider);

    return PomodoroState(
      totalSeconds: 25 * 60,
      remainingSeconds: 25 * 60,
      isRunning: false,
      sessionType: SessionPomodoro,
    );
  }

  void start() {
    if (state.isRunning) return;

    state = state.copyWith(isRunning: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final seconds = state.remainingSeconds - 1;

      if (seconds <= 0) {
        timer.cancel();

        // Reproducir sonido al finalizar
        _soundService.playDing();

        state = state.copyWith(
          isRunning: false,
          remainingSeconds: 0,
        );
        return;
      }

      state = state.copyWith(remainingSeconds: seconds);
    });
  }

  // void start() {
  //   if (state.isRunning) return;

  //   state = state.copyWith(isRunning: true);

  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     final seconds = state.remainingSeconds - 1;

  //     if (seconds <= 0) {
  //       timer.cancel();
  //       state = state.copyWith(
  //         isRunning: false,
  //         remainingSeconds: 0,
  //       );
  //       return;
  //     }

  //     state = state.copyWith(remainingSeconds: seconds);
  //   });
  // }

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

  void setSession(String type) {
    int seconds;

    switch (type) {
      case SessionShortBreak:
        seconds = 5 * 60;
        break;
      case SessionLongBreak:
        seconds = 15 * 60;
        break;
      default:
        seconds = 25 * 60;
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
    NotifierProvider<PomodoroNotifier, PomodoroState>(PomodoroNotifier.new);
