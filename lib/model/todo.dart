import 'package:json_annotation/json_annotation.dart';
part 'todo.g.dart';

@JsonSerializable()
class TodoItem {
  final String uuid;
  bool value;
  String text;

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);

  TodoItem(
    this.uuid,
    this.text,
    this.value,
  );
}
