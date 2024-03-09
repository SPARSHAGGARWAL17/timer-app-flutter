import 'dart:async';

import 'package:timer_app/model/timer_model.dart';
import 'package:timer_app/view/audio_player.dart';

enum TimerViewState {
  running,
  paused,
  completed,
}

abstract class ITimerViewModel {
  TimerViewState get currentState;

  void changeTimerState(TimerViewState currentState);

  void playTimer();

  void pauseTimer();

  void stopTimer();

  TimerModel onDispose();

  String get counter;
}

abstract class TimerViewDelegate {
  void updateUI();
  void saveTimerData();
}

class TimerViewModel implements ITimerViewModel {
  TimerViewState _currentState = TimerViewState.running;
  Timer? _timer;

  TimerViewDelegate? delegate;

  IAudioPlayer? audioPlayer;

  final TimerModel timerModel;

  String? _counter;

  TimerViewModel(this.timerModel, {this.delegate, this.audioPlayer}) {
    if (timerModel.timeInSec == 0) {
      stopTimer();
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), _timerCallback);
    }
  }

  @override
  String get counter {
    if (_counter == null) {
      return _convertTimeToString(timerModel.timeInSec);
    } else {
      return _counter!;
    }
  }

  @override
  TimerViewState get currentState => _currentState;

  void _timerCallback(Timer timer) {
    _updateCounterValue(timer.tick);
    if (timerModel.timeInSec == timer.tick) {
      audioPlayer?.play();
      stopTimer();
    }
  }

  @override
  void changeTimerState(TimerViewState currentState) {
    switch (currentState) {
      case TimerViewState.running:
        pauseTimer();
        _currentState = TimerViewState.paused;
        break;
      case TimerViewState.paused:
        _currentState = TimerViewState.running;
        playTimer();
        break;
      case TimerViewState.completed:
        break;
    }
    delegate?.updateUI();
  }

  @override
  void playTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), _timerCallback);
    delegate?.saveTimerData();
  }

  @override
  void pauseTimer() {
    int timerTick = _timer?.tick ?? 0;
    timerModel.timeInSec -= timerTick;
    _timer?.cancel();
    delegate?.saveTimerData();
  }

  @override
  TimerModel onDispose() {
    var timer = TimerModel(
      id: timerModel.id,
      title: timerModel.title,
      description: timerModel.description,
      timeInSec: timerModel.timeInSec - (_timer?.tick ?? 0),
    );
    stopTimer();
    return timer;
  }

  @override
  void stopTimer() {
    _timer?.cancel();
    timerModel.timeInSec = 0;
    _currentState = TimerViewState.completed;
    delegate?.updateUI();
    delegate?.saveTimerData();
  }

  void _updateCounterValue(int timerTick) {
    _counter = _convertTimeToString(timerModel.timeInSec - timerTick);
    delegate?.updateUI();
  }

  String _convertTimeToString(int timeInSec) {
    int hour = timeInSec ~/ 3600;
    int min = (timeInSec % 3600) ~/ 60;
    int sec = (timeInSec % 3600) % 60;
    String hourString = hour.toString().padLeft(2, "0");
    String minString = min.toString().padLeft(2, "0");
    String secString = sec.toString().padLeft(2, "0");
    return "$hourString:$minString:$secString";
  }
}
