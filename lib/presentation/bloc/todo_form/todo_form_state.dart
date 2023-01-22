part of 'todo_form_bloc.dart';

abstract class TodoFormState extends Equatable {
  const TodoFormState();

  @override
  List<Object> get props => [];
}

class TodoFormLoading extends TodoFormState {}

class TodoFormLoaded extends TodoFormState {}

class TodoFormError extends TodoFormState {}

class TodoFormInitial extends TodoFormState {}
