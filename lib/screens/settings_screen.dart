import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../states/app_state.dart';
import '../components/dialog.dart';
import '../variables/counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsChangeModal extends StatefulWidget {
  SettingsChangeModal({
    super.key,
    required this.value,
    required this.onChange,
    required this.round,
  });

  final int value;
  final Function(int) onChange;
  final String round;
  int counter = 0;

  @override
  State<SettingsChangeModal> createState() => _SettingsChangeModalState();
}

class _SettingsChangeModalState extends State<SettingsChangeModal> {
  @override
  void initState() {
    super.initState();
    widget.counter = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textStyle = theme.textTheme.displayMedium!.copyWith(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    );

    var titleStyle = theme.textTheme.displayMedium!.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 40,
    );

    void decrement() {
      setState(() {
        widget.counter -= 60;
      });
    }

    void increment() {
      setState(() {
        widget.counter += 60;
      });
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: widget.counter > 0 ? decrement : null,
                    child: Text('-', style: textStyle),
                  ),
                  SizedBox(
                    width: 36,
                  ),
                  SizedBox(
                    width: 75,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        (widget.counter / 60).round().toString(),
                        style: titleStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 36,
                  ),
                  ElevatedButton(
                    onPressed: widget.counter >= 59 * 60 ? null : increment,
                    child: Text('+', style: textStyle),
                  ),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  widget.onChange(widget.counter);
                  Navigator.of(context).pop();
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setInt(
                    widget.round,
                    widget.counter,
                  );
                },
                child: Text('x', style: textStyle),
              ),
            ],
          )),
    );
  }
}

class SettingsBlock extends StatefulWidget {
  final int value;
  final String description;
  final Function(int) onChange;
  final String round;

  const SettingsBlock({
    super.key,
    required this.value,
    required this.description,
    required this.onChange,
    required this.round,
  });

  @override
  State<SettingsBlock> createState() => _SettingsBlockState();
}

class _SettingsBlockState extends State<SettingsBlock> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var valueStyle = theme.textTheme.displayMedium!.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 32,
    );

    var descriptionStyle = theme.textTheme.displayMedium!.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return GestureDetector(
      onTap: () {
        dialog(
          SettingsChangeModal(
            value: widget.value,
            onChange: widget.onChange,
            round: widget.round,
          ),
          context,
        );
      },
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.29,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text((widget.value / 60).round().toString(), style: valueStyle),
                SizedBox(height: 5),
                Text(widget.description, style: descriptionStyle),
              ],
            )),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    appState.setupTimer();
    appState.setSource();

    return SafeArea(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          SettingsBlock(
            value: appState.durations[ROUNDS.work] as int,
            description: 'Pomodoro',
            onChange: (value) {
              appState.changeRoundDuration(ROUNDS.work, value);
            },
            round: ROUNDS.work.name,
          ),
          SizedBox(width: 15),
          SettingsBlock(
            value: appState.durations[ROUNDS.smallBreak] as int,
            description: 'Small break',
            onChange: (value) {
              appState.changeRoundDuration(ROUNDS.smallBreak, value);
            },
            round: ROUNDS.smallBreak.name,
          ),
          SizedBox(width: 15),
          SettingsBlock(
            value: appState.durations[ROUNDS.longBreak] as int,
            description: 'Long break',
            onChange: (value) {
              appState.changeRoundDuration(ROUNDS.longBreak, value);
            },
            round: ROUNDS.longBreak.name,
          ),
        ],
      ),
    ));
  }
}
