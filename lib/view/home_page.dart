import "package:flutter/material.dart";
import "package:timer_app/view/widgets/single_timer_widget.dart";
import "package:timer_app/view/widgets/spacing.dart";

class HomePage extends StatelessWidget {
  static const String route = "/";
  const HomePage({super.key});

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
        onPressed: () {},
        child: Icon(
          Icons.add_circle_outline_outlined,
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(31).copyWith(top: 20),
          itemBuilder: (context, index) {
            return TimerWidget();
          },
          separatorBuilder: (context, index) {
            return vSpacing(15);
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
