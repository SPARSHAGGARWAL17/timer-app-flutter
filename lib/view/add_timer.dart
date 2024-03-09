import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:timer_app/controller/timers_controller.dart';
import 'package:timer_app/model/timer_model.dart';
import 'package:timer_app/theme.dart';
import 'package:timer_app/view/widgets/spacing.dart';

class AddTimerSheet extends StatefulWidget {
  const AddTimerSheet({super.key});

  @override
  State<AddTimerSheet> createState() => _AddTimerSheetState();
}

class _AddTimerSheetState extends State<AddTimerSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TextEditingController hourTextController = TextEditingController(text: "00");
  TextEditingController minTextController = TextEditingController(text: "00");
  TextEditingController secTextController = TextEditingController(text: "00");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        height: MediaQuery.of(context).size.height * 0.92,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add Task",
              style: AppTextStyles.headingStyle,
            ),
            vSpacing(15),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.secondaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            vSpacing(10),
            TextFormField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: "Description",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.secondaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            vSpacing(20),
            Text(
              "Duration",
              style: AppTextStyles.bodyTextStyle.copyWith(
                color: Colors.black,
              ),
            ),
            vSpacing(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  width: 50,
                  child: TextField(
                    controller: hourTextController,
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.titleStyle
                        .copyWith(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.center,
                    maxLength: 2,
                    onSubmitted: (value) {
                      if (value.isEmpty) {
                        hourTextController.text = "00";
                      }
                    },
                    onTapOutside: (event) {
                      if (hourTextController.text.isEmpty) {
                        hourTextController.text = "00";
                      }
                    },
                    decoration: textFieldDecoration("HH"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10)
                      .copyWith(top: 8),
                  child: Text(
                    ":",
                    style:
                        AppTextStyles.titleStyle.copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: 50,
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: minTextController,
                      style: AppTextStyles.titleStyle
                          .copyWith(color: Colors.white, fontSize: 25),
                      textAlign: TextAlign.center,
                      maxLength: 2,
                      onTapOutside: (event) {
                        if (minTextController.text.isEmpty) {
                          minTextController.text = "00";
                        }
                      },
                      onSubmitted: (value) {
                        if (value.isEmpty) {
                          minTextController.text = "00";
                        }
                      },
                      onChanged: (value) {
                        if ((int.tryParse(value) ?? 0) > 59) {
                          minTextController.text = "59";
                        }
                      },
                      decoration: textFieldDecoration("MM")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10)
                      .copyWith(top: 8),
                  child: Text(
                    ":",
                    style:
                        AppTextStyles.titleStyle.copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: secTextController,
                    style: AppTextStyles.titleStyle
                        .copyWith(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.center,
                    maxLength: 2,
                    onTapOutside: (event) {
                      if (secTextController.text.isEmpty) {
                        secTextController.text = "00";
                      }
                    },
                    onSubmitted: (value) {
                      if (value.isEmpty) {
                        secTextController.text = "00";
                      }
                    },
                    onChanged: (value) {
                      if ((int.tryParse(value) ?? 0) > 59) {
                        secTextController.text = "59";
                      }
                    },
                    decoration: textFieldDecoration("SS"),
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                var time = getTimeInSec;
                if (time != 0) {
                  var model = TimerModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    timeInSec: time,
                  );
                  Provider.of<TimerController>(context, listen: false)
                      .addTimer(model);
                }
                Navigator.of(context).pop();
              },
              child: const Text("Add Task"),
            )
          ],
        ),
      ),
    );
  }

  int get getTimeInSec {
    var sec = int.tryParse(secTextController.text) ?? 0;
    var min = int.tryParse(minTextController.text) ?? 0;
    var hour = int.tryParse(hourTextController.text) ?? 0;
    return (hour * 3600) + (min * 60) + sec;
  }

  InputDecoration textFieldDecoration(String counterText) {
    return InputDecoration(
      counterText: counterText,
      contentPadding: const EdgeInsets.all(5),
      filled: true,
      fillColor: AppColors.primaryColor,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide.none,
      ),
    );
  }
}
