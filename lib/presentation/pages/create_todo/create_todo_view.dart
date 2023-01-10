import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist_supabase/core/services/todo_service.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final TextEditingController _todoController = TextEditingController();
  // final TodosService _todosService = TodosService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(
            controller: _todoController,
            decoration: InputDecoration(hintText: "Type a new Todo"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // _todosService.insertTodo(content: _todoController.text).then(
          //       (value) => Navigator.pop(context),
          //     );
        },
        icon: Icon(Icons.done),
        label: Text("Create"),
      ),
    );
  }
}
