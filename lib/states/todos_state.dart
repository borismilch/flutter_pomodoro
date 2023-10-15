import 'package:flutter/material.dart';
import 'package:calculator/model/todo.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TodoState extends ChangeNotifier {
  Map<String, TodoItem> todo = {};
  bool isInited = false;

  void addTodo(String uuid, String text, bool value) {
    todo[uuid] = TodoItem(uuid, text, value);
    notifyListeners();
    saveJson();
  }

  void editTodo(String uuid, String text) {
    if (todo[uuid] != null) {
      todo[uuid]?.text = text;
      notifyListeners();
      saveJson();
    }
  }

  void changeTodoIsDone(String uuid, bool value) {
    if (todo[uuid] != null) {
      todo[uuid]?.value = value;
      notifyListeners();
      saveJson();
    }
  }

  void removeTodo(String uuid) {
    if (todo[uuid] != null) {
      todo.remove(uuid);
      notifyListeners();
      saveJson();
    }
  }

  void saveJson() async {
    if (todo.values.isNotEmpty) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var todoList = todo.values.toList();
      List<String> payload = [];

      for (final item in todoList) {
        String value = json.encode(item.toJson());
        payload.add(value);
      }

      var finalResult = jsonEncode(payload);
      await prefs.setString('todos', finalResult);
    }
  }

  void initTodos() async {
    isInited = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? saved = prefs.getString('todos');
    if (saved == null) return;

    List<dynamic> values = jsonDecode(saved);
    var payload =
        values.map((item) => TodoItem.fromJson(json.decode(item))).toList();

    for (var item in payload) {
      todo[item.uuid] = item;
    }
  }
}
