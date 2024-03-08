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
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: viewModel.counter,
                        builder: (context, val, child) {
                          return Text(
                            val,
                            style: AppTextStyles.headingStyle,
                          );
                        }),
                    hSpacing(10),
                    ActionButton(
                      initialState:
                          viewModel.currentState == TimerCardState.running
                              ? ButtonState.pause
                              : ButtonState.play,
                      onTap: (currentState) {
                        if (currentState == ButtonState.pause) {
                          viewModel.changeTimerState(TimerCardState.running);
                        } else {
                          viewModel.changeTimerState(TimerCardState.paused);
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
                vSpacing(10),
                const Text(
                  "Boiling Egg",
                  style: AppTextStyles.titleStyle,
                ),
                vSpacing(5),
                const Text(
                  "Need to take out the egg from the boiler when this timer ends",
                  style: AppTextStyles.bodyTextStyle,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
