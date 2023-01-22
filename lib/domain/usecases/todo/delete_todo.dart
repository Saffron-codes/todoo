import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/core/usecases/usecase.dart';
import 'package:todolist_supabase/domain/entities/todo/todo.dart';
import 'package:todolist_supabase/domain/repositories/todo/todo_repository.dart';

class DeleteTodo implements UseCase<Todo, DeleteTodoParams> {
  final TodoRepository todoRepository;

  DeleteTodo({required this.todoRepository});
  @override
  Future<Either<Failure, Todo>> call(DeleteTodoParams params) async {
    return await todoRepository.deleteTodo(id: params.id);
  }
}

class DeleteTodoParams extends Equatable {
  final String id;
  const DeleteTodoParams(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
