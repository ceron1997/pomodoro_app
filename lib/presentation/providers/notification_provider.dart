import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/domain/services/notification_service.dart';
import 'package:pomodoro_app/infrastructure/services/sound_service.dart';

// This provider manages the notification service used in the app,
// allowing the TimerNotifier to trigger sound notifications when sessions end.

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return SoundService();
});
