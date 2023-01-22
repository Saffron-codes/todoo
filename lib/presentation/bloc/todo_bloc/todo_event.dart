// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetTodos extends TodoEvent {}

class EmitFailed extends TodoEvent {}
class EmitEmpty extends TodoEvent {}

class EmitLoaded extends TodoEvent {
  final List<Todo> todos;
  EmitLoaded({
    required this.todos,
  });
  @override
  List<Object> get props => [todos];
}

class UpdateTodo extends TodoEvent {}

// class DeleteTodoEvent extends TodoEvent {
//   final String id;
//   const DeleteTodoEvent(this.id);
//   @override
//   List<Object> get props => [id];
// }
