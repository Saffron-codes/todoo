part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
  
  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {}
class TodoLoaded extends TodoState {
  final List<Todo> todos;
  const TodoLoaded(this.todos);
  @override
  List<Object> get props => [todos];
}
class TodoFailed extends TodoState {}
class TodoEmpty extends TodoState {}

// class TodoDeleteSuccess extends TodoState {}
// class TodoDeleteFailed extends TodoState {}
// class TodoDeleteLoading extends TodoState {}
