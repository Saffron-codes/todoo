import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_supabase/core/services/dialog_service.dart';
import 'package:todolist_supabase/core/services/toast_service.dart';
import 'package:todolist_supabase/core/services/todo_service.dart';
import 'package:todolist_supabase/presentation/bloc/todo_form/todo_form_bloc.dart';

class CreateTodoPage extends StatelessWidget {
   CreateTodoPage({super.key});

  final TextEditingController _todoController = TextEditingController();

  final DialogService dialogService = DialogService();

  final ToastService toastService = ToastService();
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoFormBloc, TodoFormState>(
      listener: (context, state) {
        print(state);
        if(state is TodoFormLoading){
          dialogService.showLoadingDialog(context: context);
        }else if(state is TodoFormLoaded){
          toastService.successToast(message: "Added Todo");
          dialogService.closeDialog(context: context);
          Navigator.pop(context);
        }else {
          dialogService.closeDialog(context: context);
          toastService.errorToast(message: "Some error occurred");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Todo'),
        ),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextField(
              controller: _todoController,
              decoration: InputDecoration(hintText: "Type a new Todo"),
              onSubmitted: (value) {
                 BlocProvider.of<TodoFormBloc>(context)
                  .add(AddTodo(content: value));
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            BlocProvider.of<TodoFormBloc>(context)
                  .add(AddTodo(content: _todoController.text));
          },
          icon: Icon(Icons.done),
          label: Text("Create"),
        ),
      ),
    );
  }
}
