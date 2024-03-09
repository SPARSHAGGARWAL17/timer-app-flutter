import 'package:flutter/material.dart';
import 'package:timer_app/theme.dart';
import 'package:timer_app/view/model/timer_view_model.dart';
import 'package:timer_app/view/widgets/action_button.dart';
import 'package:timer_app/view/widgets/spacing.dart';

class TimerWidget extends StatefulWidget {
  final TimerViewModel viewModel;

  const TimerWidget({
    super.key,
    required this.viewModel,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    implements TimerViewDelegate {
  late TimerViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    viewModel.delegate = this;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (viewModel.currentState != TimerViewState.completed)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        viewModel.counter,
                        style: AppTextStyles.headingStyle,
                      ),
                      hSpacing(10),
                      ActionButton(
                        initialState:
                            viewModel.currentState == TimerViewState.running
                                ? ButtonState.pause
                                : ButtonState.play,
                        onTap: (currentState) {
                          if (currentState == ButtonState.pause) {
                            widget.viewModel
                                .changeTimerState(TimerViewState.running);
                          } else {
                            widget.viewModel
                                .changeTimerState(TimerViewState.paused);
                          }
                        },
                      ),
                      hSpacing(10),
                      ActionButton(
                        initialState: ButtonState.stop,
                        onTap: (currentState) {
                          widget.viewModel.stopTimer();
                        },
                      ),
                    ],
                  ),
                if (viewModel.currentState == TimerViewState.completed)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.graphic_eq_rounded,
                        color: AppColors.secondaryColor,
                      ),
                      hSpacing(20),
                      const Text(
                        "FINISHED",
                        style: AppTextStyles.headingStyle,
                      ),
                      hSpacing(20),
                      const Icon(
                        Icons.graphic_eq_rounded,
                        color: AppColors.secondaryColor,
                      )
                    ],
                  ),
                vSpacing(10),
                Text(
                  viewModel.timerModel.title,
                  style: AppTextStyles.titleStyle,
                ),
                vSpacing(5),
                Text(
                  viewModel.timerModel.description,
                  style: AppTextStyles.bodyTextStyle,
                ),
              ],
            ),
          ),
          if (viewModel.currentState == TimerViewState.completed)
            ElevatedButton(
              onPressed: () {},
              child: const Text("Mark complete"),
            )
        ],
      ),
    );
  }

  @override
  void updateUI() {
    setState(() {});
  }
}
