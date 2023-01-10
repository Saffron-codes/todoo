import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/core/usecases/usecase.dart';
import 'package:todolist_supabase/domain/entities/todo/todo.dart';
import 'package:todolist_supabase/domain/usecases/todo/get_all_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodos getAllTodos;
  TodoBloc({required this.getAllTodos}) : super(TodoLoading()) {
    final getTodos = getAllTodos.call(NoParams());
      getTodos.listen((event) {
        final result = event.fold((failure) => TodoFailure(), (todos) => todos.isEmpty?TodoEmpty():TodoLoaded(todos));
        emit(result);
      });
  }
}
