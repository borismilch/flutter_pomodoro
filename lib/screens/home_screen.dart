import 'package:calculator/states/todos_state.dart';
import 'package:flutter/material.dart';
import '../components/time_counter.dart';
import '../states/app_state.dart';
import '../components/round_select.dart';
import '../components/reset_button.dart';
import 'package:provider/provider.dart';
import '../components/pause_button.dart';
import '../components/round_status.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var todoState = context.watch<TodoState>();
    appState.setupTimer();
    appState.setSource();

    if (!appState.isInited) appState.initSettings();
    if (!todoState.isInited) todoState.initTodos();

    return SafeArea(
        child: Column(
      children: [
        SizedBox(height: 100),
        TimeCounter(),
        PauseButton(),
        SizedBox(height: 40),
        RoundStatus(),
        SizedBox(height: 40),
        RoundSelect(),
        SizedBox(height: 15),
        ResetButton(),
      ],
    ));
  }
}
