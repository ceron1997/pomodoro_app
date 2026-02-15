import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/presentation/providers/theme_provider.dart';
import 'package:pomodoro_app/presentation/widgets/drawer.dart';
import 'package:pomodoro_app/presentation/widgets/session_icon.dart';
import 'package:pomodoro_app/presentation/widgets/session_selector.dart';
import 'package:pomodoro_app/presentation/widgets/timer_display.dart';
import 'package:pomodoro_app/presentation/widgets/pomodoro_buttons.dart';

class PomodoroScreen extends ConsumerWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Pomodoro'),
        actions: [
          IconButton(
            icon: Icon(appTheme.isDarkmode
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleDarkMode();
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            // Top selector, large central timer + icon, buttons fixed at bottom
            children: const [
              SessionSelector(),
              SizedBox(height: 8),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SessionIcon(),
                      SizedBox(height: 20),
                      TimerDisplay(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: PomodoroButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
