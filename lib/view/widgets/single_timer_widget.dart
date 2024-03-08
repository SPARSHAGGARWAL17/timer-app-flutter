import 'package:flutter/material.dart';
import 'package:timer_app/theme.dart';
import 'package:timer_app/view/widgets/action_button.dart';
import 'package:timer_app/view/widgets/spacing.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "00:00:00",
                  style: AppTextStyles.headingStyle,
                ),
                hSpacing(10),
                ActionButton(initialState: ButtonState.play),
                hSpacing(10),
                ActionButton(initialState: ButtonState.stop),
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
  }
}
