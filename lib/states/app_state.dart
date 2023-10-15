import 'package:flutter/material.dart';
import '../variables/counter.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import '../variables/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppState extends ChangeNotifier {
  int workRoundStreak = 0;
  int roundStreak = 0;
  bool isInited = false;
  late int roundEnd = getDuration();
  late int roundStart = (DateTime.now().millisecondsSinceEpoch / 1000).round();
  final AudioPlayer audioPlayer = AudioPlayer();

  var durations = {
    ROUNDS.smallBreak: 5 * 60,
    ROUNDS.work: 25 * 60,
    ROUNDS.longBreak: 15 * 60,
  };

  void initSettings() async {
    isInited = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int smallBreak = await prefs.getInt(ROUNDS.smallBreak.name) ?? 0;
    int work = await prefs.getInt(ROUNDS.work.name) ?? 0;
    int longBreak = await prefs.getInt(ROUNDS.longBreak.name) ?? 0;

    if (smallBreak != 0) {
      durations[ROUNDS.smallBreak] = smallBreak;
    }

    if (work != 0) {
      durations[ROUNDS.work] = work;
    }

    if (longBreak != 0) {
      durations[ROUNDS.longBreak] = longBreak;
    }
  }

  ROUNDS currentRound = ROUNDS.work;
  bool isPaused = false;
  Timer? timer;

  int getDuration() {
    switch (currentRound) {
      case ROUNDS.work:
        return durations[ROUNDS.work]!;
      case ROUNDS.smallBreak:
        return durations[ROUNDS.smallBreak]!;
      case ROUNDS.longBreak:
        return durations[ROUNDS.longBreak]!;
    }
  }

  void changeRound(ROUNDS round) {
    currentRound = round;
    roundEnd = durations[round]!;
    roundStart = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    notifyListeners();
  }

  void selectRound(ROUNDS round) {
    changeRound(round);
    workRoundStreak = 0;
    roundStreak = 0;
  }

  void togglePaused() {
    isPaused = !isPaused;
    notifyListeners();
  }

  void setupTimer() {
    if (timer != null) {
      timer?.cancel();
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused) {
        roundEnd--;
        notifyListeners();
      }
      if (roundEnd == 0) {
        onRoundEnd();
      }
    });
  }

  void resetTimer() {
    roundEnd = durations[currentRound]!;
    roundStart = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    isPaused = true;
    workRoundStreak = 0;
    roundStreak = 0;
    notifyListeners();
  }

  void setSource() {
    audioPlayer.setSource(UrlSource(notificationSound));
  }

  void playSound() async {
    audioPlayer.resume();
  }

  void onRoundEnd() async {
    roundStreak++;
    playSound();
    if (currentRound == ROUNDS.work) {
      workRoundStreak++;
    } else if (currentRound == ROUNDS.longBreak) {
      roundStreak = 0;
      workRoundStreak = 0;
    }

    if (workRoundStreak % longBreakTimeout == 0 && workRoundStreak > 0) {
      changeRound(ROUNDS.longBreak);
    } else if (currentRound == ROUNDS.smallBreak ||
        currentRound == ROUNDS.longBreak) {
      changeRound(ROUNDS.work);
    } else {
      changeRound(ROUNDS.smallBreak);
    }

    isPaused = true;
    notifyListeners();
  }

  void changeRoundDuration(ROUNDS roundKey, int value) {
    durations[roundKey] = value;
    notifyListeners();
  }
}
