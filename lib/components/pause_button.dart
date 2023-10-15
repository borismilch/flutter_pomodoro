import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../states/app_state.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    IconData icon;

    if (appState.isPaused) {
      icon = Icons.play_circle_filled;
    } else {
      icon = Icons.pause_circle_filled;
    }

    return IconButton(
      icon: Icon(icon),
      iconSize: 70,
      onPressed: () {
        appState.togglePaused();
      },
    );
  }
}
