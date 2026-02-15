import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/presentation/providers/navigation_provider.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(navigationProvider);
    final theme = Theme.of(context);

    return NavigationDrawer(
      onDestinationSelected: (index) {
        if (index == 0) {
          ref.read(navigationProvider.notifier).state = AppScreen.pomodoro;
        } else if (index == 1) {
          ref.read(navigationProvider.notifier).state = AppScreen.settings;
        }
        Navigator.pop(context);
      },
      selectedIndex: currentScreen == AppScreen.pomodoro ? 0 : 1,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color.alphaBlend(
              Colors.white.withOpacity(0.3),
              theme.colorScheme.primary,
            ),
          ),
          child: Text(
            'Pomodoro App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        const NavigationDrawerDestination(
          label: Text('Pomodoro'),
          icon: Icon(Icons.timer_outlined),
          selectedIcon: Icon(Icons.timer),
        ),
        const NavigationDrawerDestination(
          label: Text('Configuración'),
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
