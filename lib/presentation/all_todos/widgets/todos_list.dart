import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todolist_supabase/core/models/todo.dart';
import 'package:todolist_supabase/core/viewmodels/todo_viewmodel.dart';
import 'package:todolist_supabase/presentation/all_todos/widgets/todo_card_view.dart';
import 'package:todolist_supabase/presentation/all_todos/widgets/welcome_container.dart';
import 'package:todolist_supabase/core/services/todo_service.dart';

class TodosList extends StatefulWidget {
  const TodosList({super.key});

  @override
  State<TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<List<Todo>?,TodoViewModel>(
      builder: (context, todos,todovm, child) {
        List<Todo> _unCheckedTodos = [];
        List<Todo> _checkedTodos = [];
        if (todos != null && todos.length > 1) {
          todos.forEach((todo) {
            if (!todo.isCompleted) {
              _unCheckedTodos.add(todo);
            }else{
              _checkedTodos.add(todo);
            }
          });
          return todovm.isCompletedViewMode?
          ListView.builder(
            itemBuilder: (context, index) {
              return TodoCard(todo: _checkedTodos[index]);
            },
            itemCount: _checkedTodos.length,
          )
          :ListView.builder(
            itemBuilder: (context, index) {
              return TodoCard(todo: _unCheckedTodos[index]);
            },
            itemCount: _unCheckedTodos.length,
          );
        } else if (todos == null) {
          return Center(child: CircularProgressIndicator());
        } else if (todos.length == 1) {
          return Center(
            child: Text('Connect to Internet'),
          );
        } else {
          return WelcomeContainer();
        }
      },
    );
    // return StreamBuilder(
    //   stream: _todosService.getAllTodos(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     if (snapshot.hasData) {
    //       final todos = snapshot.data;
    //       // print(snapshot.data!.length);
    //       // for (var element in todos!) {
    //       //   print(element.toString());
    //       // }
    //       return todos!.isNotEmpty?
    //        ListView.builder(
    //         itemCount: todos.length,
    //         itemBuilder: (context, index) => CheckboxListTile(
    //           title: Text(todos[index].content),
    //           value: todos[index].isCompleted,
    //           onChanged: (val) {},
    //         ),
    //       ):WelcomeContainer();
    //     }
    //     return WelcomeContainer();
    //   },
    // );
  }
}
