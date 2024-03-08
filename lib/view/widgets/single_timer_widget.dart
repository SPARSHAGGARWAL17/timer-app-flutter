import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/theme.dart';
import 'package:timer_app/view/model/timer_view_model.dart';
import 'package:timer_app/view/widgets/action_button.dart';
import 'package:timer_app/view/widgets/spacing.dart';

class TimerWidget extends StatelessWidget {
  final TimerCardViewModel viewModel;

  const TimerWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<TimerCardViewModel>(builder: (context, val, child) {
        return Card(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (val.currentState != TimerCardState.completed)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            val.counter,
                            style: AppTextStyles.headingStyle,
                          ),
                          hSpacing(10),
                          ActionButton(
                            initialState:
                                val.currentState == TimerCardState.running
                                    ? ButtonState.pause
                                    : ButtonState.play,
                            onTap: (currentState) {
                              if (currentState == ButtonState.pause) {
                                viewModel
                                    .changeTimerState(TimerCardState.running);
                              } else {
                                viewModel
                                    .changeTimerState(TimerCardState.paused);
                              }
                            },
                          ),
                          hSpacing(10),
                          ActionButton(
                            initialState: ButtonState.stop,
                            onTap: (currentState) {
                              viewModel.stopTimer();
                            },
                          ),
                        ],
                      ),
                    if (val.currentState == TimerCardState.completed)
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
                      val.timerModel.title,
                      style: AppTextStyles.titleStyle,
                    ),
                    vSpacing(5),
                    Text(
                      val.timerModel.description,
                      style: AppTextStyles.bodyTextStyle,
                    ),
                  ],
                ),
              ),
              if (val.currentState == TimerCardState.completed)
                ElevatedButton(
                  
                  onPressed: () {},
                  child: const Text("Mark complete"),
                )
            ],
          ),
        );
      }),
    );
  }
}
