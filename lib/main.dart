import 'package:calculator/layout/layout.dart';
import 'package:flutter/material.dart';
import 'states/app_state.dart';
import 'states/todos_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyAppState>(create: (context) => MyAppState()),
        ChangeNotifierProvider<TodoState>(create: (context) => TodoState()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AppLayout(),
      ),
    );
  }
}
