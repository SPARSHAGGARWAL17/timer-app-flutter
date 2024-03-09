import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final ButtonState initialState;
  final void Function(ButtonState currentState) onTap;
  const ActionButton(
      {super.key, required this.initialState, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(initialState);
      },
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: const Color(0xff5B5B7D),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Icon(
          getIconBasedOnState(initialState),
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  IconData getIconBasedOnState(ButtonState state) {
    switch (state) {
      case ButtonState.play:
        return Icons.play_arrow_rounded;
      case ButtonState.pause:
        return Icons.pause;
      case ButtonState.stop:
        return Icons.stop;
    }
  }
}

enum ButtonState {
  play,
  pause,
  stop,
}
