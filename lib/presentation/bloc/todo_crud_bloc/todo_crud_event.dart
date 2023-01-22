part of 'todo_crud_bloc.dart';

abstract class TodoCrudEvent extends Equatable {
  const TodoCrudEvent();

  @override
  List<Object> get props => [];
}


class DeleteTodoEvent extends TodoCrudEvent{
  final String id;
  const DeleteTodoEvent(this.id);
}


class UpdateTodoEvent extends TodoCrudEvent{}
class ResetState extends TodoCrudEvent{}
