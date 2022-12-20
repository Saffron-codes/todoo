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

    return provider.StreamProvider<List<Todo>?>(
      create: (context) => _todosService.getAllTodos(),
      initialData: null,
      catchError: (context, error) {
        return [
          Todo(
              id: "0",
              content: "content",
              isCompleted: false,
              createdAt: "createdAt")
        ];
      },
      child: provider.ChangeNotifierProvider(
        create: (context) => TodoViewModel(),
        child: provider.Consumer<TodoViewModel>(
          builder: (context,todovm,child) {
            return Scaffold(
              appBar: AppBar(
                // title: Text('My Todos'),
                title: DropdownButton(
                      value: todovm.isCompletedViewMode?1:2,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(10),
                      items: [
                        DropdownMenuItem(child: Text('Completed'),value: 1),
                        DropdownMenuItem(child: Text('Remaining'),value: 2,),
                      ],
                      onChanged: (val) {
                        todovm.setisCompletedViewMode= val==1?true:false;
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
          }
        ),
      ),
    );
  }
}
