import 'package:just_audio/just_audio.dart';

class AudioMessageController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  AudioPlayer get audioPlayer => _audioPlayer;

  Future<void> play(String audioFilePath) async {
    await _audioPlayer.setFilePath(audioFilePath);
    _audioPlayer.play();
    isPlaying = true;
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    isPlaying = false;
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
