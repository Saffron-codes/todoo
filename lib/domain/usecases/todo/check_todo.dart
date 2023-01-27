// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/core/usecases/usecase.dart';
import 'package:todolist_supabase/domain/entities/todo/todo.dart';

import '../../repositories/todo/todo_repository.dart';

class CheckTodo implements UseCase<Todo,CheckTodoParams> {
  final TodoRepository todorepository;

  CheckTodo({required this.todorepository});
  @override
  Future<Either<Failure, Todo>> call(CheckTodoParams params)async {
    return await todorepository.checkTodo(id: params.id, value: params.value);
  }
  
}


class CheckTodoParams extends Equatable {
  String id;
  bool value;
  CheckTodoParams({
    required this.id,
    required this.value,
  });
  
  @override
  List<Object?> get props => [id,value];

}
