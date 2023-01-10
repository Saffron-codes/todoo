import 'dart:convert';

class Todo {
  String id;
  String content;
  bool isCompleted;
  String createdAt;
  Todo({
    required this.id,
    required this.content,
    required this.isCompleted,
    required this.createdAt,
  });

  Todo copyWith({
    String? id,
    String? content,
    bool? isCompleted,
    String? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      content: content ?? this.content,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      content: map['content'] as String,
      isCompleted: map['isCompleted'] as bool,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todo(id: $id, content: $content, isCompleted: $isCompleted, createdAt: $createdAt)';
  }
}
