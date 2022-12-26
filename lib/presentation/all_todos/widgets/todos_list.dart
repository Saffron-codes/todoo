import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_supabase/core/models/todo.dart';
import 'package:todolist_supabase/core/viewmodels/todo_viewmodel.dart';
import 'package:todolist_supabase/presentation/all_todos/widgets/todo_card_view.dart';
import 'package:todolist_supabase/presentation/all_todos/widgets/welcome_container.dart';

class TodosList extends StatefulWidget {
  const TodosList({super.key});

  @override
  State<TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  @override
  Widget build(BuildContext context) {
    final todolist = Provider.of<TodoList>(context);
    final todovm = Provider.of<TodoViewModel>(context);
    if (todolist is Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (todolist is TodoListContent) {
        List<Todo> _unCheckedTodos = [];
        List<Todo> _checkedTodos = [];
        todolist.data.forEach(
          (todo) {
            if (!todo.isCompleted) {
              _unCheckedTodos.add(todo);
            } else {
              _checkedTodos.add(todo);
            }
          },
        );
        return todovm.isCompletedViewMode
            ? _checkedTodos.isNotEmpty? ListView.builder(
                itemBuilder: (_, index) {
                  final Todo todo = _checkedTodos[index];
                  return TodoCard(todo: todo);
                },
                itemCount: _checkedTodos.length,
              ):WelcomeContainer()
            : _unCheckedTodos.isNotEmpty? ListView.builder(
                itemBuilder: (_, index) {
                  final Todo todo = _unCheckedTodos[index];
                  return TodoCard(todo: todo);
                },
                itemCount: _unCheckedTodos.length,
              ):WelcomeContainer();
    } else {
      return Center(child: Text('Some Error Occurred',style: TextStyle(color: Colors.redAccent),),);
    }
  }
}
