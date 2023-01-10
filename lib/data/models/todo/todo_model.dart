import 'package:todolist_supabase/domain/entities/todo/todo.dart';

class TodoModel extends Todo {
  String id;
  String content;
  bool isCompleted;
  String createdAt;
  TodoModel({
    required this.id,
    required this.content,
    required this.isCompleted,
    required this.createdAt,
  }) : super(
          id: id,
          content: content,
          isCompleted: isCompleted,
          createdAt: createdAt,
        );

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      content: map['content'] as String,
      isCompleted: map['isCompleted'] as bool,
      createdAt: map['createdAt'] as String,
    );
  }
}
