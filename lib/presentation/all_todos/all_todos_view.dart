import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist_supabase/core/models/todo.dart';
import 'package:todolist_supabase/core/viewmodels/todo_viewmodel.dart';
import 'package:todolist_supabase/presentation/all_todos/widgets/todos_list.dart';
import 'package:todolist_supabase/presentation/all_todos/widgets/welcome_container.dart';
import 'package:todolist_supabase/core/services/authentication_service.dart';
import 'package:todolist_supabase/core/services/todo_service.dart';
import 'package:provider/provider.dart' as provider;

import '../../core/viewmodels/auth_viewmodel.dart';

class AllTodosView extends StatefulWidget {
  const AllTodosView({super.key});

  @override
  State<AllTodosView> createState() => _AllTodosViewState();
}

class _AllTodosViewState extends State<AllTodosView> {
  final AuthService _authenticationService = AuthService();
  final TodosService _todosService = TodosService();
  @override
  Widget build(BuildContext context) {
    AuthViewModel _authViewModel = provider.Provider.of<AuthViewModel>(context);

    return provider.StreamProvider<TodoList>(
        // value: TodoListContent(_todosService.getAllTodos()).data,
        create: (context) {
          final todosStream = _todosService.getAllTodos();
          final todosList = todosStream.map((todos){
            return TodoListContent(todos);
          });
          return todosList;
          // yield TodoListContent(todosStream.map((todos) => todos));
        },
        initialData: Loading(),
        catchError: (_, error) => Error(error.toString()),
        builder: (context, child) {
          return provider.ChangeNotifierProvider(
            create: (context) => TodoViewModel(),
            child: provider.Consumer<TodoViewModel>(
                builder: (context, todovm, child) {
              return Scaffold(
                appBar: AppBar(
                  // title: Text('My Todos'),
                  title: DropdownButton(
                    value: todovm.isCompletedViewMode ? 1 : 2,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(10),
                    items: [
                      DropdownMenuItem(child: Text('Completed'), value: 1),
                      DropdownMenuItem(
                        child: Text('Remaining'),
                        value: 2,
                      ),
                    ],
                    onChanged: (val) {
                      todovm.setisCompletedViewMode = val == 1 ? true : false;
                    },
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => _authViewModel.logout(context: context),
                      icon: Icon(Icons.logout_rounded),
                    )
                  ],
                ),
                body: TodosList(),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () => Navigator.pushNamed(context, '/create'),
                  icon: Icon(Icons.add),
                  label: Text("Add"),
                ),
              );
            }),
          );
        });
  }
}
