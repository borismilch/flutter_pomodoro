import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../states/app_state.dart';

class TimeCounter extends StatelessWidget {
  const TimeCounter({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    double fontSize = 60.0;
    Duration duration = Duration(seconds: appState.roundEnd);

    String minutes = duration.inMinutes.toString();
    String seconds = (duration.inSeconds % 60).toString();

    if (seconds.length == 1) {
      seconds = "0" + seconds;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '$minutes:$seconds',
          style:
              style.copyWith(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
