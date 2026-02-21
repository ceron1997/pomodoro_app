import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/config/theme/app_theme.dart';
import 'package:pomodoro_app/infrastructure/local_storage/preferences_service.dart';
import 'package:pomodoro_app/presentation/providers/settings_dependencies.dart.dart';

// This provider manages the app's theme state,
// including the selected color and dark mode preference.

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  final preferencesService = ref.watch(preferencesServiceProvider);
  return ThemeNotifier(preferencesService);
});

class ThemeNotifier extends StateNotifier<AppTheme> {
  final PreferencesService _preferencesService;

  ThemeNotifier(this._preferencesService) : super(AppTheme()) {
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    try {
      await _preferencesService.init();
      state = AppTheme(
        selectedColor: _preferencesService.getSelectedColor(),
        isDarkmode: _preferencesService.getDarkMode(),
      );
      if (kDebugMode) {
        print('Preferences loaded successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading preferences: $e');
      }
    }
  }

  Future<void> toggleDarkMode() async {
    final newValue = !state.isDarkmode;
    state = state.copyWith(isDarkmode: newValue);
    await _preferencesService.setDarkMode(newValue);
    if (kDebugMode) {
      print('Dark mode changed to: $newValue');
    }
  }

  Future<void> changeColor(int index) async {
    if (index < 0 || index >= colorList.length) return;
    state = state.copyWith(selectedColor: index);
    await _preferencesService.setSelectedColor(index);
    if (kDebugMode) {
      print('Color changed to index: $index');
    }
  }
}
