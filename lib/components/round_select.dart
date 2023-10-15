import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../states/app_state.dart';
import '../variables/counter.dart';

class RoundSelect extends StatelessWidget {
  const RoundSelect({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    var items = [
      DropdownMenuItem(
        value: ROUNDS.work,
        child: Text(ROUNDS.work.name),
      ),
      DropdownMenuItem(
        value: ROUNDS.longBreak,
        child: Text(ROUNDS.longBreak.name),
      ),
      DropdownMenuItem(
        value: ROUNDS.smallBreak,
        child: Text(ROUNDS.smallBreak.name),
      ),
    ];

    int selectedIndex = items.indexWhere(
      (element) => element.value == appState.currentRound,
    );

    var saved = items[selectedIndex];
    items.removeAt(selectedIndex);
    items.insert(0, saved);

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.blue.shade200,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue.shade200,
          ),
          child: DropdownButton<ROUNDS>(
            onChanged: (ROUNDS? value) {
              appState.selectRound(value as ROUNDS);
            },
            items: items,
            value: appState.currentRound,
            underline: Container(),
          ),
        ),
      ),
    );
  }
}
