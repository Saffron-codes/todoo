import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist_supabase/core/services/toast_service.dart';
import 'package:todolist_supabase/domain/entities/todo/todo.dart';

import '../../../bloc/todo_crud_bloc/todo_crud_bloc.dart';

class ToDoTile extends StatelessWidget {
  final Todo todo;

  ToDoTile({super.key, required this.todo});


  final ToastService toastService = ToastService();

  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCrudBloc, TodoCrudState>(
      listener: (context, state) {
        // print(state);
        if (state is TodoDeleteLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Deleting...'))
          );
        } else if (state is TodoDeleteSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Successfully Deleted'))
          );
        } else if (state is TodoDeleteFailed || state is TodoCheckFailed) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Some error Occurred'))
          );
        } else if(state is TodoCheckLoading){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: state.value?Text('Checking...'):Text('UnChecking....'))
          );
        }
        else if (state is TodoCheckSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Checked'))
          );
        } 
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
          child: Slidable(
            endActionPane: ActionPane(
              motion: BehindMotion(),
              // motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    BlocProvider.of<TodoCrudBloc>(context)
                        .add(DeleteTodoEvent(todo.id));
                  },
                  icon: Icons.delete,
                  backgroundColor: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(12),
                  autoClose: (state is TodoDeleteLoading),
                )
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                // color: Colors.yellow,
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, //New
                      blurRadius:
                          Theme.of(context).brightness != Brightness.dark
                              ? 3.0
                              : 0.0,
                      offset: Theme.of(context).brightness != Brightness.dark
                          ? Offset(0, 1)
                          : Offset(0, 0))
                ],
              ),
              child: Row(
                children: [
                  // checkbox
                  Checkbox(
                    value: todo.isCompleted,
                    onChanged: (val) {
                      BlocProvider.of<TodoCrudBloc>(context).add(CheckTodoEvent(todo.id, val??false));
                    },
                    activeColor: Colors.black,
                  ),

                  // task name
                  Text(
                    todo.content,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
