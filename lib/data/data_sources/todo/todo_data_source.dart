// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:todolist_supabase/data/models/todo/todo_model.dart';

abstract class TodoRemoteDataSource {
  Stream<List<TodoModel>> getAllTodos();
  Future<TodoModel> insertTodo(String content);
  Future<TodoModel> updateTodo(String id);
  Future<TodoModel> deleteTodo(String id);
  Future<TodoModel> checkTodo(String id, bool isChecked);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  SupabaseClient client;
  TodoRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<TodoModel> checkTodo(String id, bool isChecked) {
    // TODO: implement checkTodo
    throw UnimplementedError();
  }

  @override
  Future<TodoModel> deleteTodo(String id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Stream<List<TodoModel>> getAllTodos() async* {
    final userId = client.auth.currentUser!.id;
    yield* client
        .from('todos')
        .stream(primaryKey: ['id'])
        .eq('userId', userId)
        .order('createdAt')
        .map(
          (todosMap) {
            return todosMap.map(
              (todoMap) {
                return TodoModel.fromMap(
                  todoMap,
                );
              },
            ).toList();
          },
        );
  }

  @override
  Future<TodoModel> insertTodo(String content) {
    // TODO: implement insertTodo
    throw UnimplementedError();
  }

  @override
  Future<TodoModel> updateTodo(String id) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
