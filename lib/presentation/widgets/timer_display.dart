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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final diameter = (maxWidth * 0.72).clamp(220.0, 360.0);
          final stroke = (diameter * 0.03).clamp(4.0, 12.0);
          final fontSize = (diameter * 0.22).clamp(32.0, 72.0);

          return SizedBox(
            width: diameter,
            height: diameter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: diameter,
                  height: diameter,
                  child: CircularProgressIndicator(
                    value: state.progress,
                    strokeWidth: stroke,
                    backgroundColor: theme.colorScheme.surfaceContainerHigh,
                  ),
                ),
                Text(
                  state.formattedTime,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
