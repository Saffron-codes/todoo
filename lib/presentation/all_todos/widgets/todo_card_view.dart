import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todolist_supabase/core/models/todo.dart';
import 'package:todolist_supabase/core/viewmodels/todo_viewmodel.dart';

class TodoCard extends StatefulWidget {
  Todo todo;
   TodoCard({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    final todo = widget.todo;
    return Consumer<TodoViewModel>(
      builder: (context,todovm,child) {
        return Container(
          margin: EdgeInsets.only(left: 6, right: 6),
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: todo.isCompleted,
                  onChanged: (val)async {
                    print(val);
                    await todovm.checkTodo(id: todo.id, value: val);
                  },
                ),
                Text(todo.content),
                Spacer(),
                // IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
                PopupMenuButton<String>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Edit'),
                      value: 'Update',
                    ),
                    PopupMenuItem(
                      child: Text('Delete'),
                      value: 'Delete',
                    )
                  ],
                  onSelected:(value)async {
                    if(value == 'Delete'){
                      await todovm.deleteTodo(id:todo.id);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  position: PopupMenuPosition.under,
                  // offset: Offset(10000,20.0),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
