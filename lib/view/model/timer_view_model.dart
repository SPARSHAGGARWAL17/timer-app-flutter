import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_app/model/timer_model.dart';

class TimerCardViewModel extends ChangeNotifier {
  TimerCardState _currentState = TimerCardState.running;
  Timer? _timer;

  final TimerModel timerModel;

  final ValueNotifier<String> _counter = ValueNotifier("00:00:00");

  TimerCardViewModel(this.timerModel) {
    if (timerModel.timerInSec == 0) {
      markTimerAsCompleted();
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), _timerCallback);
    }
  }

  ValueNotifier<String> get counter => _counter;

  TimerCardState get currentState => _currentState;

  void _timerCallback(Timer timer) {
    _updateCounterValue(timer.tick);
    if (timerModel.timerInSec == timer.tick) {
      markTimerAsCompleted();
    }
  }

  void changeTimerState(TimerCardState currentState) {
    switch (currentState) {
      case TimerCardState.running:
        pauseTimer();
        _currentState = TimerCardState.paused;
        break;
      case TimerCardState.paused:
        _currentState = TimerCardState.running;
        playTimer();
        break;
      case TimerCardState.completed:
        break;
    }
    notifyListeners();
  }

  void playTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), _timerCallback);
  }

  void pauseTimer() {
    int timerTick = _timer?.tick ?? 0;
    timerModel.timerInSec -= timerTick;
    _timer?.cancel();
  }

  void stopTimer() {
    _timer?.cancel();
    timerModel.timerInSec = 0;
    _updateCounterValue(0);
    _currentState = TimerCardState.completed;
  }

  void _updateCounterValue(int timerTick) {
    _counter.value = _convertTimeToString(timerModel.timerInSec - timerTick);
  }

  void markTimerAsCompleted() {
    _timer?.cancel();
    _currentState = TimerCardState.completed;
    timerModel.timerInSec = 0;
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

enum TimerCardState {
  running,
  paused,
  completed,
}
