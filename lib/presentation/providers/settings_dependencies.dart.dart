import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/domain/repositories/settings_repository.dart';
import 'package:pomodoro_app/infrastructure/local_storage/preferences_service.dart';
import 'package:pomodoro_app/infrastructure/repositories/preferences_settings_repository.dart';

// This file centralizes the providers for settings-related dependencies,
// such as the SettingsRepository and PreferencesService.

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  return PreferencesService();
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final prefs = ref.read(preferencesServiceProvider);
  return PreferencesSettingsRepository(prefs);
});
