import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/config/theme/app_theme.dart';
import 'package:pomodoro_app/presentation/providers/theme_provider.dart';
import 'package:pomodoro_app/presentation/widgets/drawer.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appTheme = ref.watch(themeNotifierProvider);

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
          ],
        ),
      ),
    );
  }
}
