import 'package:flutter/material.dart';

class EditTodoModal extends StatefulWidget {
  final String text;
  final String uuid;
  final Function(String, String) changeTodo;

  const EditTodoModal({
    super.key,
    required this.text,
    required this.uuid,
    required this.changeTodo,
  });

  @override
  State<EditTodoModal> createState() => _EditTodoModaState();
}

class _EditTodoModaState extends State<EditTodoModal> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    void onClose() {
      Navigator.of(context).pop();
    }

    return SizedBox(
        height: 170,
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Flexible(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter name of the task',
                    focusColor: Colors.green,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: onClose,
                    color: Colors.red,
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 12),
                  MaterialButton(
                    onPressed: () {
                      widget.changeTodo(widget.uuid, controller.text);
                      onClose();
                    },
                    color: Colors.blue,
                    child: Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
