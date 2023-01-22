import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist_supabase/core/services/dialog_service.dart';
import 'package:todolist_supabase/core/services/toast_service.dart';
import 'package:todolist_supabase/domain/entities/todo/todo.dart';
import 'package:todolist_supabase/presentation/bloc/todo_bloc/todo_bloc.dart';

import '../../../bloc/todo_crud_bloc/todo_crud_bloc.dart';

class ToDoTile extends StatelessWidget {
  // final String taskName;
  // final bool taskCompleted;
  // Function(bool?)? onChanged;
  // Function(BuildContext)? deleteFunction;
  final Todo todo;

  ToDoTile({super.key, required this.todo});

  IconData renderDeleteStateIcon(TodoCrudState state) {
    if (state is TodoDeleteLoading) {
      return Icons.pending;
    } else if (state is TodoDeleteSuccess) {
      return Icons.done;
    } else if (state is TodoDeleteFailed) {
      return Icons.refresh;
    } else {
      return Icons.delete;
    }
  }

  final ToastService toastService = ToastService();

  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCrudBloc, TodoCrudState>(
      listener: (context, state) {
        if (state is TodoDeleteLoading) {
          toastService.infoToast(message: "Deleting....");
        } else if (state is TodoDeleteSuccess) {
          toastService.successToast(message: "Successfully Deleted");
        } else if (state is TodoDeleteFailed) {
          toastService.errorToast(message: "Some error Occurred");
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
          child: Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {},
                  icon: Icons.edit,
                  backgroundColor: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                SlidableAction(
                  onPressed: (context) {
                    BlocProvider.of<TodoCrudBloc>(context)
                        .add(DeleteTodoEvent(todo.id));
                    // state is TodoDeleteSuccess?BlocProvider.of<TodoCrudBloc>(context).add(ResetState()):null;
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
                    onChanged: (val) {},
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
