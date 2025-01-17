// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

   ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
     required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.blue.shade800,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              
              //checkbox
              Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  checkColor: Colors.blueAccent,
                  activeColor: Colors.black,),
              
              // task name
              Text(taskName,
              style: TextStyle(
                color: Colors.white,
                  decoration: taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
