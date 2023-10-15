// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) => TodoItem(
      json['uuid'] as String,
      json['text'] as String,
      json['value'] as bool,
    );

Map<String, dynamic> _$TodoItemToJson(TodoItem instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'value': instance.value,
      'text': instance.text,
    };
