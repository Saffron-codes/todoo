import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist_supabase/domain/usecases/todo/create_todo.dart';


part 'todo_form_event.dart';
part 'todo_form_state.dart';

class TodoFormBloc extends Bloc<TodoFormEvent, TodoFormState> {
  final CreateTodo createTodo;
  TodoFormBloc({required this.createTodo}) : super(TodoFormInitial()) {
    on<AddTodo>((event, emit)async {
      emit(TodoFormLoading());
      InserTodoParams params = InserTodoParams(content: event.content);
      final failureOrTodo = await createTodo.call(params);
      final result = failureOrTodo.fold((l) => TodoFormError(), (r) => TodoFormLoaded());
      emit(result);
    });
  }
}


