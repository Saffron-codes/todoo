import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_supabase/core/error/exceptions.dart';
import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/data/data_sources/todo/todo_data_source.dart';
import 'package:todolist_supabase/domain/entities/todo/todo.dart';
import 'package:todolist_supabase/domain/repositories/todo/todo_repository.dart';

class TodosRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource todoRemoteDataSource;

  TodosRepositoryImpl({required this.todoRemoteDataSource});

  @override
  Future<Either<TodoFailure, Todo>> checkTodo(
      {required String id, required bool value})async {
    try {
      final checkedTodo = await todoRemoteDataSource.checkTodo(id, value);
      return Right(checkedTodo);
    } on DatabaseException {
      return Left(TodoFailure());
    }
  }

  @override
  Future<Either<TodoFailure, Todo>> deleteTodo({required String id})async {
    try {
      final deletedTodo = await todoRemoteDataSource.deleteTodo(id);
      return Right(deletedTodo);
    } on DatabaseException {
      return Left(TodoFailure());
    }
  }

  @override
  Stream<List<Todo>> getAllTodos() {
    return todoRemoteDataSource.getAllTodos();
  }

  @override
  Future<Either<TodoFailure, Todo>> insertTodo(
      {required String content}) async {
    try {
      final todo = await todoRemoteDataSource.insertTodo(content);
      return Right(todo);
    } on TodoFailure {
      return Left(TodoFailure());
    }
  }

  @override
  Future<Either<TodoFailure, Todo>> updateTodo({required String id}) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}




  //   // final userId = supabase.auth.currentUser!.id;
  //   // return supabase
  //   //     .from('todos')
  //   //     .stream(primaryKey: ['id'])
  //   //     .eq('userId', userId)
  //   //     .order('createdAt')
  //   //     .map(
  //   //       (todosMap) {
  //   //         return todosMap.map(
  //   //           (todoMap) {
  //   //             return Todo.fromMap(
  //   //               todoMap,
  //   //             );
  //   //           },
  //   //         ).toList();
  //   //       },
  //   //     );
  // }

  // @override
  // Future insertTodo({required String content}) async {
  //   final userId = supabase.auth.currentUser!.id;
  //   await supabase
  //       .from('todos')
  //       .insert({'content': content, 'isCompleted': false, 'userId': userId});
  // }

  // @override
  // Future updateTodo({required String id}) async {}
  // @override
  // Future checkTodo({required String id, required bool? value}) async {
  //   try {
  //     await supabase.from('todos').update({'isCompleted': value}).eq('id', id);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future deleteTodo({required String id}) async {
  //   await supabase.from('todos').delete().match({'id': id});
  // }