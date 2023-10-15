import 'package:flutter/material.dart';
import '../screens/settings_screen.dart';

class MenuLink extends StatelessWidget {
  const MenuLink({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
    }

    return IconButton(onPressed: onPressed, icon: Icon(Icons.menu));
  }
}
