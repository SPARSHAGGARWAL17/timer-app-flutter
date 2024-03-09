import "package:flutter/material.dart";
import "package:timer_app/model/timer_model.dart";
import "package:timer_app/view/add_timer.dart";
import "package:timer_app/view/model/timer_view_model.dart";
import "package:timer_app/view/widgets/single_timer_widget.dart";
import "package:timer_app/view/widgets/spacing.dart";

class HomePage extends StatefulWidget {
  static const String route = "/";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TimerViewModel> timers = [
    TimerViewModel(
      TimerModel(title: "Egg boiling", description: "Test", timerInSec: 7210),
    ),
    TimerViewModel(
      TimerModel(title: "Egg boiling", description: "Test", timerInSec: 10),
    ),
    TimerViewModel(
      TimerModel(title: "Egg boiling", description: "Test", timerInSec: 11),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Potato Timer"),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            context: context,
            builder: (context) {
              return AddTimerSheet();
            },
          );
        },
        child: Icon(
          Icons.add_circle_outline_outlined,
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(31).copyWith(top: 20),
          itemBuilder: (context, index) {
            return TimerWidget(
              viewModel: timers[index],
            );
          },
          separatorBuilder: (context, index) {
            return vSpacing(15);
          },
          itemCount: timers.length,
        ),
      ),
    );
  }
}
