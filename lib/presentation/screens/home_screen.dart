import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/presentation/providers/navigation_provider.dart';
import 'package:pomodoro_app/presentation/providers/timer_notifier.dart';
import 'package:pomodoro_app/presentation/screens/pomodoro_screen.dart';
import 'package:pomodoro_app/presentation/screens/settings_screen.dart';
import 'package:pomodoro_app/presentation/widgets/drawer.dart';

// HomeScreen acts as the application shell (App Shell Pattern).
//
// Responsibilities:
// - Provides the main Scaffold structure of the app.
// - Contains the global Drawer used for navigation.
// - Decides which primary screen (Pomodoro or Settings) is displayed
//   based on the navigationProvider state.
// - Listens to app lifecycle events (via WidgetsBindingObserver)
//   to notify the PomodoroNotifier when the app resumes,
//   ensuring the timer recalculates correctly after being in background.
//
// Architectural Notes:
// - This widget does NOT contain business logic.
// - It does NOT manage timer logic directly.
// - It only reacts to system-level events and delegates behavior
//   to the appropriate Riverpod notifier.
//
// Why lifecycle logic lives here:
// - HomeScreen is the highest persistent visible widget under MaterialApp.
// - It remains alive while the app is running.
// - Lifecycle events affect the entire application, not just a single screen.
// - Therefore, it is the correct place to bridge system events
//   and application state (through providers).
//
// If future features are added (e.g., push notifications, background sync,
// bottom navigation, etc.), this file may evolve into a more complete
// application shell, but should continue delegating logic to providers.

class HomeScreen extends ConsumerStatefulWidget with WidgetsBindingObserver {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // Se ejecuta cuando el HomeScreen se crea por primera vez
// Aquí registramos el observer del lifecycle
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Se ejecuta cuando el HomeScreen se elimina del árbol
// Quitamos el observer para evitar memory leaks
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Se llama cada vez que cambia el estado de la app
// Si la app vuelve del background (resumed),
// recalculamos el tiempo del Pomodoro
    if (state == AppLifecycleState.resumed) {
      ref.read(pomodoroProvider.notifier).recalculateOnResume();
    }
  }

  @override
  Widget build(BuildContext context) {
    // este es el contenido de la pantalla
    final currentScreen = ref.watch(navigationProvider);

    return Scaffold(
      drawer: const DrawerWidget(),
      body: currentScreen == AppScreen.pomodoro
          ? const PomodoroScreen()
          : const SettingsScreen(),
    );
  }
}
