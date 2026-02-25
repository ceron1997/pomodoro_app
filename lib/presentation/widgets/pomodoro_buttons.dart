import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/presentation/providers/timer_notifier.dart';

// The PomodoroButtons widget provides the control buttons for the Pomodoro timer,
// including Start, Pause, and Reset. It listens to the pomodoroProvider to control
// the timer state when the buttons are pressed. The buttons are styled to match
// the app's theme and provide a user-friendly interface for controlling the timer.

class PomodoroButtons extends ConsumerWidget {
  const PomodoroButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // RESET
        IconButton(
          onPressed: () => ref.read(pomodoroProvider.notifier).reset(),
          iconSize: 40,
          icon: const Icon(Icons.refresh),
          color: theme.colorScheme.primary,
        ),

        const SizedBox(width: 40),

        // PAUSA
        IconButton(
          onPressed: () => ref.read(pomodoroProvider.notifier).pause(),
          iconSize: 40,
          icon: const Icon(Icons.pause),
          color: theme.colorScheme.primary,
        ),

        const SizedBox(width: 40),

        // START
        ElevatedButton.icon(
          onPressed: () => ref.read(pomodoroProvider.notifier).start(),
          icon: const Icon(Icons.play_arrow, size: 32),
          label: const Text(
            "Start",
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
