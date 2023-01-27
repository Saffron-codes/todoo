part of 'todo_crud_bloc.dart';

abstract class TodoCrudState extends Equatable {
  const TodoCrudState();
  
  @override
  List<Object> get props => [];
}

class TodoCrudInitial extends TodoCrudState {}


class TodoDeleteLoading extends TodoCrudState {}
class TodoDeleteSuccess extends TodoCrudState {}
class TodoDeleteFailed extends TodoCrudState {}


class TodoUpdateLoading extends TodoCrudState {}
class TodoUpdateSuccess extends TodoCrudState {}
class TodoUpdateFailed extends TodoCrudState {}


class TodoCheckLoading extends TodoCrudState {
  final bool value;
  const TodoCheckLoading(this.value);
}
class TodoCheckSuccess extends TodoCrudState {}
class TodoCheckFailed extends TodoCrudState {}