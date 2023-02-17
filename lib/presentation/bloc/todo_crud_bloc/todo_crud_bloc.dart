import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist_supabase/domain/usecases/todo/check_todo.dart';
import 'package:todolist_supabase/domain/usecases/todo/delete_todo.dart';

part 'todo_crud_event.dart';
part 'todo_crud_state.dart';

class TodoCrudBloc extends Bloc<TodoCrudEvent, TodoCrudState> {
  final DeleteTodo deleteTodo;
  final CheckTodo checkTodo;

  TodoCrudBloc({required this.deleteTodo,required this.checkTodo}) : super(TodoCrudInitial()) {


    on<DeleteTodoEvent>((event, emit) async {
      emit(TodoDeleteLoading());
      DeleteTodoParams deleteTodoParams = DeleteTodoParams(event.id);
      final failureOrTodo = await deleteTodo(deleteTodoParams);
      final state = failureOrTodo.fold(
          (l) => TodoDeleteFailed(), (r) => TodoDeleteSuccess());
      emit(state);
    });

    on<CheckTodoEvent>((event, emit)async{
      emit(TodoCheckLoading(event.value));
      CheckTodoParams checkTodoParams = CheckTodoParams(id: event.id, value: event.value);
      final failureOrTodo = await checkTodo(checkTodoParams);
      final state = failureOrTodo.fold((l) => TodoCheckFailed(), (r) => TodoCheckSuccess());
      emit(state); 
    });

    // on<ResetState>((event, emit)async {
    //   await Future.delayed(Duration(seconds: 2));
    //   emit(TodoCrudInitial());
    // });
  }
}
