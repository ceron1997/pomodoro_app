import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppScreen { pomodoro, settings }

final navigationProvider =
    StateProvider<AppScreen>((ref) => AppScreen.pomodoro);
