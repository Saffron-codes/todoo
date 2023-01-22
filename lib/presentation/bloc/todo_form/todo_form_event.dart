part of 'todo_form_bloc.dart';

abstract class TodoFormEvent extends Equatable {
  const TodoFormEvent();

  @override
  List<Object> get props => [];
}
class AddTodo extends TodoFormEvent {
  String content;
  AddTodo({
    required this.content,
  });
  @override
  List<Object> get props => [content];
}