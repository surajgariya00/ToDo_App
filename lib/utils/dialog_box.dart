import 'package:flutter/material.dart';
import 'my_button.dart';
import 'package:intl/intl.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priorityController;
  final TextEditingController dueDateController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.priorityController,
    required this.dueDateController,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  Future<void> _selectDueDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      dueDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Change the background color
      content: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(
              255, 248, 248, 248), // Set a different color for the content area
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title", // Use labelText for a floating label effect
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Description
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Priority
            TextField(
              controller: priorityController,
              decoration: InputDecoration(
                labelText: "Priority",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Due Date
            TextFormField(
              controller: dueDateController,
              onTap: () => _selectDueDate(context),
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Due Date",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),

            const SizedBox(height: 24),

            // Buttons -> Save + Cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save button
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                  buttonColor: Colors.green, // Customize button color
                  textColor: Colors.white, // Customize text color
                ),

                const SizedBox(width: 8),

                // Cancel button
                MyButton(
                  text: "Cancel",
                  onPressed: onCancel,
                  buttonColor: Colors.red, // Customize button color
                  textColor: Colors.white, // Customize text color
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
