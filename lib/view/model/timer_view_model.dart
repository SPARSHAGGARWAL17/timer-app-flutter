import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_app/model/timer_model.dart';

class TimerCardViewModel {
  TimerCardState _currentState = TimerCardState.running;
  Timer? _timer;

  final TimerModel timerModel;

  final ValueNotifier<String> _counter = ValueNotifier("00:00:00");

  TimerCardViewModel(this.timerModel) {
    if (timerModel.timerInSec == 0) {
      markTimerAsCompleted();
      _timer?.cancel();
    } else {
      _timer =
          Timer.periodic(Duration(seconds: timerModel.timerInSec), (timer) {
        _counter.value =
            _convertTimeToString(timerModel.timerInSec - timer.tick);
      });
    }
  }

  ValueNotifier<String> get counter => _counter;

  TimerCardState get currentState => _currentState;

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
  completed,
}
