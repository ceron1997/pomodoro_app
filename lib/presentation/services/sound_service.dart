import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final soundServiceProvider = Provider<SoundService>((ref) {
  return SoundService();
});

class SoundService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playDing() async {
    try {
      await _player.play(
        AssetSource('sounds/ding.mp3'),
        volume: 1.0,
      );
    } catch (e) {
      print('Error reproduciendo sonido: $e');
    }
  }
}
