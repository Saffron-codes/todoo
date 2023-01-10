import '../../../domain/entities/todo/todo.dart';

abstract class TodoState {}

class TodoLoadingState implements TodoState {
  const TodoLoadingState();
}

class TodoLoadSuccessState implements TodoState {
  TodoLoadSuccessState(this.data);
  final List<Todo> data;
}

class TodoLoadFailedState implements TodoState {
  TodoLoadFailedState(this.message);
  final String message;
}
