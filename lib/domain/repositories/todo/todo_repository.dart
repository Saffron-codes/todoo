import 'package:dartz/dartz.dart';
import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/domain/entities/todo/todo.dart';

abstract class TodoRepository {
  Stream<List<Todo>> getAllTodos();

  Future<Either<TodoFailure,Todo>> insertTodo({required String content});

  Future<Either<TodoFailure,Todo>> updateTodo({required String id});

  Future<Either<TodoFailure,Todo>> checkTodo({required String id,required bool value});

  Future<Either<TodoFailure,Todo>> deleteTodo({required String id});
}
