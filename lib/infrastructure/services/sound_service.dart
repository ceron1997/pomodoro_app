import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:pomodoro_app/domain/services/notification_service.dart';

// This file implements the SoundService, which is responsible
// for playing sound notifications in the app. It uses the audioplayers package to play a
// "ding" sound when a Pomodoro session ends.
// The SoundService is provided to the rest of the app through the notificationServiceProvider,
// allowing the TimerNotifier to trigger sound notifications without
// needing to know the implementation details.

class SoundService implements NotificationService {
  final AudioPlayer _player = AudioPlayer();

  @override
  Future<void> playDing() async {
    try {
      await _player.play(
        AssetSource('sounds/ding.mp3'),
        volume: 1.0,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error reproduciendo sonido: $e');
      }
    }
  }
}
