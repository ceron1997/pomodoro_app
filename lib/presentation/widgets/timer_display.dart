import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/presentation/providers/timer_notifier.dart';

class TimerDisplay extends ConsumerWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pomodoroProvider);
    final theme = Theme.of(context);

    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: 7,
              child: CircularProgressIndicator(
                value: state.progress,
                strokeWidth: 4,
                backgroundColor: theme.colorScheme.surfaceVariant,
              ),
            ),
            Text(
              state.formattedTime,
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
