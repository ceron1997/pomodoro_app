import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/config/theme/app_theme.dart';
import 'package:pomodoro_app/presentation/providers/settings_provider.dart';
import 'package:pomodoro_app/presentation/providers/theme_provider.dart';
import 'package:pomodoro_app/presentation/widgets/drawer.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appTheme = ref.watch(themeNotifierProvider);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Configuración'),
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
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Tema
            ListTile(
              title: const Text('Tema Oscuro'),
              trailing: Switch(
                value: appTheme.isDarkmode,
                onChanged: (value) {
                  ref.read(themeNotifierProvider.notifier).toggleDarkMode();
                },
              ),
            ),
            const Divider(),
            // Color del tema
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Color del Tema'),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  colorList.length,
                  (index) => GestureDetector(
                    onTap: () {
                      ref
                          .read(themeNotifierProvider.notifier)
                          .changeColor(index);
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: colorList[index],
                            shape: BoxShape.circle,
                          ),
                        ),
                        if (appTheme.selectedColor == index)
                          Positioned.fill(
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Divider(),
            // Duración Pomodoro
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Duración del Pomodoro'),
                      Text(
                        '${settings.pomodoroDuration} min',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: settings.pomodoroDuration.toDouble(),
                    min: 25,
                    max: 60,
                    divisions: 35,
                    label: '${settings.pomodoroDuration} min',
                    onChanged: (value) {
                      ref
                          .read(settingsProvider.notifier)
                          .changePomodoroDuration(value.toInt());
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '25 min',
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        '60 min',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            // Duración Descanso Corto
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Duración del Descanso Corto'),
                      Text(
                        '${settings.shortBreakDuration} min',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: settings.shortBreakDuration.toDouble(),
                    min: 5,
                    max: 10,
                    divisions: 5,
                    label: '${settings.shortBreakDuration} min',
                    onChanged: (value) {
                      ref
                          .read(settingsProvider.notifier)
                          .changeShortBreakDuration(value.toInt());
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '5 min',
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        '10 min',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            // Duración Descanso Largo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Duración del Descanso Largo'),
                      Text(
                        '${settings.longBreakDuration} min',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: settings.longBreakDuration.toDouble(),
                    min: 11,
                    max: 20,
                    divisions: 9,
                    label: '${settings.longBreakDuration} min',
                    onChanged: (value) {
                      ref
                          .read(settingsProvider.notifier)
                          .changeLongBreakDuration(value.toInt());
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '11 min',
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        '20 min',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
