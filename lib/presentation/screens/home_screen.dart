import 'package:flutter/material.dart';
import 'package:pomodoro_app/presentation/widgets/session_selector.dart';
import 'package:pomodoro_app/presentation/widgets/timer_display.dart';
import 'package:pomodoro_app/presentation/widgets/pomodoro_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SessionSelector(),
              TimerDisplay(),
              PomodoroButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
