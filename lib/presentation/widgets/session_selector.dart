import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/presentation/providers/timer_notifier.dart';

class SessionSelector extends ConsumerWidget {
  const SessionSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final active = ref.watch(pomodoroProvider).sessionType;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(
          theme,
          sessionLabels[sessionPomodoro]!,
          active == sessionPomodoro,
          () => ref.read(pomodoroProvider.notifier).setSession(sessionPomodoro),
        ),
        _buildButton(
          theme,
          sessionLabels[sessionShortBreak]!,
          active == sessionShortBreak,
          () =>
              ref.read(pomodoroProvider.notifier).setSession(sessionShortBreak),
        ),
        _buildButton(
          theme,
          sessionLabels[sessionLongBreak]!,
          active == sessionLongBreak,
          () =>
              ref.read(pomodoroProvider.notifier).setSession(sessionLongBreak),
        ),
      ],
    );
  }

  Widget _buildButton(
    ThemeData theme,
    String text,
    bool isActive,
    VoidCallback onPressed,
  ) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor:
            isActive ? theme.colorScheme.primary : theme.colorScheme.surface,
        foregroundColor: isActive ? Colors.white : theme.colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }
}
