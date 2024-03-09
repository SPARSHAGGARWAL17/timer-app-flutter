import 'package:flutter_test/flutter_test.dart';
import 'package:timer_app/controller/timers_controller.dart';
import 'package:timer_app/model/timer_model.dart';

import 'mocks/database_mock.dart';

void main() {
  late TimerController timerController;
  late MockDatabase database;
  setUp(() {
    database = MockDatabase();
    timerController = TimerController(database: database);
  });

  test("Test: No timer is active", () async {
    database.stubbedGetData = [];
    await timerController.loadActiveTimers();
    expect(timerController.activeTimers.length, 0);
  });

  test("Test: Add a new timer", () async {
    database.stubbedInsertData = 1;
    var model = TimerModel(
        title: "First", description: "First description", timeInSec: 120);
    await timerController.addTimer(model);
    expect(model.id, 1);
    expect(timerController.activeTimers.length, 1);
  });

  test("Test: One timer is active and user relaunches the app", () async {
    var model = TimerModel(
        title: "First", description: "First description", timeInSec: 120);
    database.stubbedGetData = [model.toMap(true)];
    await timerController.loadActiveTimers();
    expect(timerController.activeTimers.length, 1);
  });

  test("Test: Mark timer as complete and remove it", () async {
    database.stubbedInsertData = 1;
    var model = TimerModel(
        title: "First", description: "First description", timeInSec: 120);
    await timerController.addTimer(model);
    expect(timerController.activeTimers.length, 1);
    timerController.removeTimer(1);
    expect(timerController.activeTimers.length, 0);
    expect(database.invokedDeleteData, true);
    expect(database.invokedDeleteDataCount, 1);
  });

  test("Test: Save timer data in local database on user action", () {
    var model = TimerModel(
        title: "First", description: "First description", timeInSec: 120);
    timerController.saveTimerData(model);
    expect(database.invokedUpdateData, true);
    expect(database.invokedUpdateDataCount, 1);
  });

  test("Test: Save current state of timers on detach app life cycle state",
      () async {
    database.stubbedInsertData = 1;
    var model = TimerModel(
        title: "First", description: "First description", timeInSec: 120);
    await timerController.addTimer(model);
    expect(timerController.activeTimers.length, 1);
    timerController.saveCurrentTimerState();
    expect(database.invokedUpdateData, true);
    expect(database.invokedUpdateDataCount, 1);
  });

  test("Test: dispose()", () async {
    var model = TimerModel(
        title: "First", description: "First description", timeInSec: 120);
    await timerController.addTimer(model);
    expect(timerController.activeTimers.length, 1);
    timerController.dispose();
  });
}
