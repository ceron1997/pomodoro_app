import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/presentation/providers/timer_notifier.dart';

class SessionIcon extends ConsumerWidget {
  const SessionIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(pomodoroProvider).sessionType;
    return _buildIcon(sessionIcons[active]!);
  }

  Widget _buildIcon(IconData icon) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = constraints.maxWidth > 0
            ? (constraints.maxWidth * 0.12).clamp(48.0, 96.0)
            : 72.0;

        return Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Icon(
              icon,
              size: size,
            ),
          ),
        );
      },
    );
  }
}
