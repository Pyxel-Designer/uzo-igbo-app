import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  Future<void> playAudio(String assetPath) async {
    try {
      isPlaying = true;
      await _player.stop();

      // Normalize path to .wav if needed
      String path = assetPath;
      if (path.endsWith('.mp3')) {
        path = path.replaceAll('.mp3', '.wav');
      }

      await _player.play(AssetSource(path.replaceFirst('assets/', '')));
      _player.onPlayerComplete.listen((_) {
        isPlaying = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Audio playback info: $assetPath ($e)");
      }
      isPlaying = false;
    }
  }

  Future<void> playTone(String toneProfile) async {
    final lower = toneProfile.toLowerCase();
    String wav = 'audio/default.wav';

    if (lower.contains('high') && lower.contains('low') && lower.indexOf('high') < lower.indexOf('low')) {
      wav = 'audio/tone_high_low.wav';
    } else if (lower.contains('low') && lower.contains('high')) {
      wav = 'audio/tone_low_high.wav';
    } else if (lower.contains('high')) {
      wav = 'audio/tone_high_high.wav';
    } else if (lower.contains('low')) {
      wav = 'audio/tone_low_low.wav';
    }

    try {
      await _player.stop();
      await _player.play(AssetSource(wav));
    } catch (e) {
      if (kDebugMode) {
        print("Tone playback: $wav ($e)");
      }
    }
  }

  Future<void> stop() async {
    await _player.stop();
    isPlaying = false;
  }
}
