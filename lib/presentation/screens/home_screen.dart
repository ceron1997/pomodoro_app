import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/presentation/providers/navigation_provider.dart';
import 'package:pomodoro_app/presentation/screens/pomodoro_screen.dart';
import 'package:pomodoro_app/presentation/screens/settings_screen.dart';
import 'package:pomodoro_app/presentation/widgets/drawer.dart';

// The HomeScreen is the main screen of the application that displays either
// the Pomodoro timer or the settings screen based on the user's navigation choice.
// It uses a Drawer for navigation and listens to the navigationProvider
// to determine which screen to display. The HomeScreen is a ConsumerWidget,
// allowing it to react to changes in the navigation state and update the UI accordingly.
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
