import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../states/app_state.dart';
import '../variables/counter.dart';
import 'package:dots_indicator/dots_indicator.dart';

class RoundStatus extends StatelessWidget {
  const RoundStatus({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
        child: DotsIndicator(
      dotsCount: totalRounds,
      position: appState.roundStreak,
      decorator: DotsDecorator(
        color: Colors.grey, // Inactive color
        activeColor: Colors.white,
      ),
    ));
  }
}
