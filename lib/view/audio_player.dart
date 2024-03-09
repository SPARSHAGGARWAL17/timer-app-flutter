import 'package:audioplayers/audioplayers.dart';

abstract class IAudioPlayer {
  void play();
  void stop();
}

class AppAudioPlayer implements IAudioPlayer {
  static final AppAudioPlayer _internal = AppAudioPlayer._();

  AppAudioPlayer._();

  factory AppAudioPlayer() => _internal;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void play() {
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource("audio/iphone_alarm.mp3"));
  }

  @override
  void stop() {
    _audioPlayer.stop();
  }
}
