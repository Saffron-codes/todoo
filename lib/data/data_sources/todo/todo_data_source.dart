// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_supabase/core/error/exceptions.dart';
import 'package:todolist_supabase/core/error/failures.dart';

import 'package:todolist_supabase/data/models/todo/todo_model.dart';

abstract class TodoRemoteDataSource {
  Stream<List<TodoModel>> getAllTodos();
  Future<TodoModel> insertTodo(String content);
  Future<TodoModel> deleteTodo(String id);
  Future<TodoModel> checkTodo(String id, bool isChecked);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  SupabaseClient client;
  TodoRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<TodoModel> checkTodo(String id, bool isChecked) async {
    final List<dynamic> data = await client
        .from('todos')
        .update({'isCompleted': isChecked})
        .eq('id', id)
        .select()
        .onError((error, stackTrace) {
          throw DatabaseException();
        });
    return TodoModel.fromMap(data[0]);
  }

  @override
  Future<TodoModel> deleteTodo(String id) async {
    final List<dynamic> data = await client
        .from('todos')
        .delete()
        .match({'id': id})
        .select()
        .onError((error, stackTrace) {
          throw DatabaseException();
        });
    return TodoModel.fromMap(data[0]);
  }

  @override
  Stream<List<TodoModel>> getAllTodos() {
    final userId = client.auth.currentUser!.id;
    return client
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
        )
        .handleError((obj) {
          // print("Todo Error");
          throw TodoFailure();
        });
  }

  @override
  Future<TodoModel> insertTodo(String content) async {
    final List<dynamic> todoMap = await client
        .from('todos')
        .insert({
          'content': content,
          'isCompleted': false,
          'userId': client.auth.currentUser!.id
        })
        .select()
        .onError((error, stackTrace) {
          throw TodoFailure();
        });
    return TodoModel.fromMap(todoMap[0]);
  }
}
