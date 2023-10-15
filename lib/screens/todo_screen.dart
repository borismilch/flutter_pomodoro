import 'package:flutter/material.dart';
import 'todo_screen/todo_form.dart';
import 'todo_screen/todo_list.dart';

class TodoScreen extends StatefulWidget {
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 30,
      fontWeight: FontWeight.w600,
    );

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text('Todos', style: style),
            SizedBox(height: 12),
            CreateTodoForm(),
            TodoItemsList(),
          ],
        ),
      ),
    );
  }
}
