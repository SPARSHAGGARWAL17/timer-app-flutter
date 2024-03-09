import 'package:flutter/material.dart';
import 'package:timer_app/database/db.dart';
import 'package:timer_app/model/timer_model.dart';
import 'package:timer_app/view/model/timer_view_model.dart';

class TimerController extends ChangeNotifier {
  final IDatabase database;

  TimerController({required this.database});

  List<TimerViewModel> activeTimers = [];

  Future<void> loadActiveTimers() async {
    var rawTimerData = await database.getData();
    List<TimerModel> timerList = List<TimerModel>.from(
      rawTimerData.map(
        (e) => TimerModel.fromMap(e as Map<String, dynamic>),
      ),
    );
    activeTimers = timerList.map((e) => TimerViewModel(e)).toList();
    notifyListeners();
  }

  Future<void> addTimer(TimerModel timer) async {
    var id = await database.insertData(timer.toMap());
    timer.id = id;
    activeTimers.add(TimerViewModel(timer));
    notifyListeners();
  }

  void removeTimer(int id) async {
    activeTimers.removeWhere((element) => element.timerModel.id == id);
    notifyListeners();
    database.deleteData(id);
  }

  void saveCurrentTimerState() {
    for (var i in activeTimers) {
      var currentState = i.onDispose();
      database.updateData(currentState.toMap(true));
    }
  }
}
