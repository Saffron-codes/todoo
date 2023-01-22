// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/core/usecases/usecase.dart';
import 'package:todolist_supabase/domain/entities/todo/todo.dart';

import '../../repositories/todo/todo_repository.dart';

class CreateTodo implements UseCase<Todo,InserTodoParams> {
  final TodoRepository todorepository;

  CreateTodo({required this.todorepository});
  @override
  Future<Either<Failure, Todo>> call(InserTodoParams params)async {
    return await todorepository.insertTodo(content: params.content);
  }
  
}


class InserTodoParams extends Equatable {
  String content;
  InserTodoParams({
    required this.content,
  });
  @override
  List<Object?> get props => [content];

}
