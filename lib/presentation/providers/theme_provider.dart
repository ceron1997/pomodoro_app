import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/config/theme/app_theme.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    if (kDebugMode) {
      print('this is the current theme: ${state.isDarkmode}');
    }
    state = state.copyWith(isDarkmode: !state.isDarkmode);
  }

  void changeColor(int index) {
    if (index < 0 || index >= colorList.length) return;
    state = state.copyWith(selectedColor: index);
  }
}
