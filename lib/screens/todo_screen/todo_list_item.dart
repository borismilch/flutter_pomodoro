import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator/states/todos_state.dart';
import 'package:calculator/components/dialog.dart';
import 'package:calculator/screens/todo_screen/edit_todo_modal.dart';

class TodoListItem extends StatefulWidget {
  final bool value;
  final String text;
  final String uuid;
  final Function(bool) onChange;

  const TodoListItem(
      {super.key,
      required this.text,
      required this.value,
      required this.onChange,
      required this.uuid});

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    var todoState = context.watch<TodoState>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Checkbox(
              value: widget.value,
              onChanged: (bool? value) {
                widget.onChange(value as bool);
              },
            ),
            Text(
              widget.text,
              style: widget.value
                  ? TextStyle(decoration: TextDecoration.lineThrough)
                  : TextStyle(),
            ),
          ]),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  todoState.removeTodo(widget.uuid);
                },
                icon: Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () {
                  dialog(
                    EditTodoModal(
                      text: widget.text,
                      uuid: widget.uuid,
                      changeTodo: todoState.editTodo,
                    ),
                    context,
                  );
                },
                icon: Icon(Icons.edit),
              ),
            ],
          )
        ],
      ),
    );
  }
}
