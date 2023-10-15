import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../states/app_state.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return MaterialButton(
      color: Colors.blue,
      onPressed: () => appState.resetTimer(),
      child: Text(
        'Reset',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
