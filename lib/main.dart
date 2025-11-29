import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/config/theme/app_theme.dart';
import 'package:pomodoro_app/presentation/providers/theme_provider.dart';
import 'package:pomodoro_app/presentation/screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: PomodoroApp()));
}

class PomodoroApp extends ConsumerWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
      home: const HomeScreen(),
    );
  }
}
