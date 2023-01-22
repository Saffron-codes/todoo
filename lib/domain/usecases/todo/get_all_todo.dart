import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/core/usecases/usecase.dart';
import 'package:todolist_supabase/domain/entities/todo/todo.dart';
import 'package:todolist_supabase/domain/repositories/todo/todo_repository.dart';

/// This usecase implements the get all todos for current user
///
/// has a stream of either [Failure] or [List<Todo>]

class GetAllTodos implements StreamUseCase<Stream<List<Todo>>, NoParams> {
  final TodoRepository todorepository;

  GetAllTodos({required this.todorepository});
  
  @override
  Stream<List<Todo>> call(NoParams params) {
   return todorepository.getAllTodos();
  }

 
}
