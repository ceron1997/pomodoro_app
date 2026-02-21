import 'package:flutter_riverpod/flutter_riverpod.dart';

// This provider manages the current screen of the app,
// allowing the UI to react to navigation changes between
// the Pomodoro timer and the settings screen.

enum AppScreen { pomodoro, settings }

final navigationProvider =
    StateProvider<AppScreen>((ref) => AppScreen.pomodoro);
