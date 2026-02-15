import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/presentation/providers/navigation_provider.dart';
import 'package:pomodoro_app/presentation/screens/pomodoro_screen.dart';
import 'package:pomodoro_app/presentation/screens/settings_screen.dart';
import 'package:pomodoro_app/presentation/widgets/drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(navigationProvider);

    return Scaffold(
      drawer: DrawerWidget(),
      body: currentScreen == AppScreen.pomodoro
          ? const PomodoroScreen()
          : const SettingsScreen(),
    );
  }
}
