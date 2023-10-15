import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
    required this.onChange,
    required this.currentIndex,
  });
  final Function(int) onChange;
  final int currentIndex;

  @override
  State<BottomNavigation> createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.red[600],
      selectedItemColor: Colors.white,
      currentIndex: widget.currentIndex,
      onTap: (value) {
        widget.onChange(value);
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          label: 'Pomodoro',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box),
          label: 'Todolist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
