// ignore_for_file: public_meber_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ToDoTile extends StatelessWidget {
  final String title;
  final String description;
  final int priority;
  final DateTime dueDate;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction; // Add edit function

  ToDoTile({
    Key? key,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.taskCompleted,
    this.onChanged,
    this.deleteFunction,
    this.editFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 130, 198, 82),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: Colors.black,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Description: $description'),
              const SizedBox(height: 8),
              Text('Priority: $priority'),
              const SizedBox(height: 8),
              Text(
                  'Due Date: ${DateFormat('yyyy-MM-dd').format(dueDate)}'), // Format the date without time
            ],
          ),
        ),
      ),
    );
  }
}
