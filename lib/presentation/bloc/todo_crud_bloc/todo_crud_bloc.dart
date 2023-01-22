import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist_supabase/domain/usecases/todo/delete_todo.dart';

part 'todo_crud_event.dart';
part 'todo_crud_state.dart';

class TodoCrudBloc extends Bloc<TodoCrudEvent, TodoCrudState> {
  final DeleteTodo deleteTodo;

  TodoCrudBloc({required this.deleteTodo}) : super(TodoCrudInitial()) {
    on<DeleteTodoEvent>((event, emit) async {
      emit(TodoDeleteLoading());
      DeleteTodoParams deleteTodoParams = DeleteTodoParams(event.id);
      final failureOrTodo = await deleteTodo(deleteTodoParams);
      final state = failureOrTodo.fold(
          (l) => TodoDeleteFailed(), (r) => TodoDeleteSuccess());
      emit(state);
      // emit(TodoCrudInitial());
    });

    // on<ResetState>((event, emit)async {
    //   await Future.delayed(Duration(seconds: 2));
    //   emit(TodoCrudInitial());
    // });
  }
}
