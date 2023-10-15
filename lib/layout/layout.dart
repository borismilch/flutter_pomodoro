import 'package:flutter/material.dart';
import './bottom_navigation.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/todo_screen.dart';

class AppLayout extends StatefulWidget {
  @override
  State<AppLayout> createState() => _AppLayoutState();

  const AppLayout({
    super.key,
  });
}

class _AppLayoutState extends State<AppLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget getCurrentPage(int value) {
      switch (value) {
        case 0:
          return MyHomePage();
        case 1:
          return TodoScreen();
        case 2:
          return SettingsScreen();
      }

      throw UnimplementedError();
    }

    void onChangeIndex(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: Colors.redAccent,
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
        onChange: onChangeIndex,
      ),
      body: getCurrentPage(currentIndex),
    );
  }
}
