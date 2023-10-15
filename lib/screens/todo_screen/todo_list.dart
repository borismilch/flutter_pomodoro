import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_list_item.dart';
import 'package:calculator/states/todos_state.dart';
import 'package:calculator/model/todo.dart';

class TodoItemsList extends StatefulWidget {
  const TodoItemsList({super.key});

  @override
  State<TodoItemsList> createState() => _TodoItemsListState();
}

class _TodoItemsListState extends State<TodoItemsList> {
  @override
  Widget build(BuildContext context) {
    var todoState = context.watch<TodoState>();
    List<TodoItem> items = todoState.todo.values.toList();

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return TodoListItem(
            text: item.text,
            value: item.value,
            uuid: item.uuid,
            onChange: (bool value) {
              todoState.changeTodoIsDone(item.uuid, value);
            },
          );
        },
      ),
    );
  }
}
