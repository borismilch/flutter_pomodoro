import 'package:flutter/material.dart';

class Dlg extends StatelessWidget {
  final Widget child;

  const Dlg({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

void dialog(Widget child, BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: child,
      );
    },
  );
}
