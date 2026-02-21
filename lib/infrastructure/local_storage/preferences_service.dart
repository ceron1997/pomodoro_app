import 'package:shared_preferences/shared_preferences.dart';

// This file implements the PreferencesService, which is responsible for managing
// local storage of user preferences using the shared_preferences package.
// It provides methods to save and retrieve settings such as the selected color,
// dark mode preference, and durations for Pomodoro, short break, and long break sessions.
// The PreferencesService is used by the PreferencesSettingsRepository
// to persist user settings across app sessions.

class PreferencesService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Color
  Future<void> setSelectedColor(int color) async {
    await _prefs.setInt('selected_color', color);
  }

  int getSelectedColor() {
    return _prefs.getInt('selected_color') ?? 0;
  }

  // Tema Oscuro
  Future<void> setDarkMode(bool isDark) async {
    await _prefs.setBool('is_darkmode', isDark);
  }

  bool getDarkMode() {
    return _prefs.getBool('is_darkmode') ?? false;
  }

  // Duración Pomodoro
  Future<void> setPomodoroDuration(int minutes) async {
    await _prefs.setInt('pomodoro_duration', minutes);
  }

  int getPomodoroDuration() {
    return _prefs.getInt('pomodoro_duration') ?? 25;
  }

  // Duración Descanso Corto
  Future<void> setShortBreakDuration(int minutes) async {
    await _prefs.setInt('short_break_duration', minutes);
  }

  int getShortBreakDuration() {
    return _prefs.getInt('short_break_duration') ?? 5;
  }

  // Duración Descanso Largo
  Future<void> setLongBreakDuration(int minutes) async {
    await _prefs.setInt('long_break_duration', minutes);
  }

  int getLongBreakDuration() {
    return _prefs.getInt('long_break_duration') ?? 15;
  }
}
