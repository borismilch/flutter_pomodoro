import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:calculator/states/todos_state.dart';
import 'package:provider/provider.dart';

class CreateTodoForm extends StatefulWidget {
  const CreateTodoForm({super.key});

  @override
  State<CreateTodoForm> createState() => _CreateTodoFormState();
}

class _CreateTodoFormState extends State<CreateTodoForm> {
  @override
  Widget build(BuildContext context) {
    var todoState = context.watch<TodoState>();
    final controller = TextEditingController();
    var uuid = Uuid();

    void createTodoItem() {
      if (controller.text.isEmpty) return;
      todoState.addTodo(uuid.v4(), controller.text, false);
      controller.clear();
    }

    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Enter Name of the task',
                  focusColor: Colors.green,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: createTodoItem,
              child: Text('Create', style: TextStyle(color: Colors.white)),
            ),
          ],
        ));
  }
}
