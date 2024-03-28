import 'package:flutter/material.dart';
import 'package:to_do_app/model/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(Task) onTaskChanged;
  final Function(String) onDeleteItem;

  const TaskItem({
    super.key,
    required this.task,
    required this.onTaskChanged,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () {
          onTaskChanged(task);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: task.isDone
            ? const Color.fromARGB(255, 225, 225, 225)
            : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: task.isDone
            ? const Icon(Icons.check_box, color: Colors.cyan)
            : const Icon(Icons.check_box_outline_blank, color: Colors.cyan),
        title: Text(
          task.taskText!,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: const Color.fromARGB(255, 255, 0, 0),
            iconSize: 25,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(task.id!);
            },
          ),
        ),
      ),
    );
  }
}
