import 'package:audioplayers/audioplayers.dart';

abstract class IAudioPlayer {
  void play();
  void stop();
}

class AppAudioPlayer implements IAudioPlayer {
  bool _isPlaying = false;

  static final AppAudioPlayer _internal = AppAudioPlayer._();

  AppAudioPlayer._();

  factory AppAudioPlayer() => _internal;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void play() {
    if (_isPlaying) {
      _audioPlayer.stop();
    }
    _isPlaying = true;
    _audioPlayer.play(AssetSource("audio/iphone_alarm.mp3")).then((value) {
      _isPlaying = false;
    });
  }

  @override
  void stop() {
    _isPlaying = false;
    _audioPlayer.stop();
  }
}
