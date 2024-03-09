import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:timer_app/controller/timers_controller.dart";
import "package:timer_app/view/add_timer.dart";
import "package:timer_app/view/widgets/single_timer_widget.dart";
import "package:timer_app/view/widgets/spacing.dart";

class HomePage extends StatefulWidget {
  static const String route = "/";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TimerController>(context, listen: false).loadActiveTimers();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
      print(state);
    switch (state) {
      case AppLifecycleState.detached:
        Provider.of<TimerController>(context, listen: false).saveCurrentTimerState();
        break;
      default:
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
              return const AddTimerSheet();
            },
          );
        },
        child: const Icon(
          Icons.add_circle_outline_outlined,
        ),
      ),
      body: SafeArea(
        child: Consumer<TimerController>(builder: (context, val, child) {
          return ListView.separated(
            padding: const EdgeInsets.all(31).copyWith(top: 20),
            itemBuilder: (context, index) {
              return TimerWidget(
                key: ValueKey(val.activeTimers[index].timerModel.id),
                viewModel: val.activeTimers[index],
              );
            },
            separatorBuilder: (context, index) {
              return vSpacing(15);
            },
            itemCount: val.activeTimers.length,
          );
        }),
      ),
    );
  }
}
