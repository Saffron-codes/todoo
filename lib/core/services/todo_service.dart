import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_supabase/core/models/todo.dart';

class TodosService {
  final supabase = Supabase.instance.client;

  Stream<List<Todo>> getAllTodos() {
    final userId = supabase.auth.currentUser!.id;
    return supabase
        .from('todos')
        .stream(primaryKey: ['id'])
        .eq('userId', userId)
        .order('createdAt')
        .map(
          (todosMap) {
            return todosMap.map(
              (todoMap) {
                return Todo.fromMap(
                  todoMap,
                );
              },
            ).toList();
          },
        );
  }

  Future insertTodo({required String content}) async {
    final userId = supabase.auth.currentUser!.id;
    await supabase
        .from('todos')
        .insert({'content': content, 'isCompleted': false, 'userId': userId});
  }

  Future updateTodo({required String id}) async {}

  Future checkTodo({required String id, required bool? value}) async {
    try {
      await supabase.from('todos').update({'isCompleted': value}).eq('id', id);
    } catch (e) {
      print(e);
    }
  }

  Future deleteTodo({required String id}) async {
    await supabase.from('todos').delete().match({'id': id});
  }
}
