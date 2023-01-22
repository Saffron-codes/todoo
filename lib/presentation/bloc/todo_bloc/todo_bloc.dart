import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/core/usecases/usecase.dart';
import 'package:todolist_supabase/domain/entities/todo/todo.dart';
import 'package:todolist_supabase/domain/usecases/todo/delete_todo.dart';
import 'package:todolist_supabase/domain/usecases/todo/get_all_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodos getAllTodos;
  // final DeleteTodo deleteTodo;
  late StreamSubscription getalltodoStreamSubscription;
  TodoBloc({required this.getAllTodos}) : super(TodoLoading()) {
    on<EmitLoaded>((event, emit) {
      emit(TodoLoaded(event.todos));
    });

    on<EmitFailed>((event, emit) {
      emit(TodoFailed());
    });

    on<EmitEmpty>((event, emit) {
      emit(TodoEmpty());
    });
    on<GetTodos>((event, emit) async {
      final todosStream = await getAllTodos.call(NoParams());
      todosStream.handleError((obj) {
        add(EmitFailed());
      }).listen((todos) {
        if(todos.isEmpty){
         add(EmitEmpty());
        }else {
          add(EmitLoaded(todos: todos));
        }
      });
    });

    // on<DeleteTodoEvent>((event, emit)async{
    //   DeleteTodoParams deleteTodoParams = DeleteTodoParams(event.id);
    //   final failureOrTodo = await deleteTodo(deleteTodoParams);
    //   final state = failureOrTodo.fold((l) => TodoDeleteFailed(), (r) => TodoDeleteSuccess());
    //   emit(state);
    // });
  }
  @override
  Future<void> close() {
    // getalltodoStreamSubscription.cancel();
    return super.close();
  }
}
