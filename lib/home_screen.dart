import 'package:flutter/material.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priorityController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _searchController = TextEditingController();

  List<Map<String, dynamic>> toDoList = [
    {
      "title": "Make",
      "description": "Do something",
      "priority": 1,
      "dueDate": DateTime.now().toLocal().subtract(Duration(
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
            seconds: DateTime.now().second,
          )),
      "completed": false
    },
    {
      "title": "Todo",
      "description": "Another task",
      "priority": 2,
      "dueDate": DateTime.now().toLocal(),
      "completed": true
    },
  ];

  @override
  void initState() {
    super.initState();
    // Sort the toDoList by priority when the app starts
    toDoList.sort((a, b) => b["priority"].compareTo(a["priority"]));
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index]["completed"] = value ?? false;
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          titleController: _titleController,
          descriptionController: _descriptionController,
          priorityController: _priorityController,
          dueDateController: _dueDateController,
          onSave: saveNewTask,
          onCancel: () {
            // Clear controllers on cancel
            _titleController.clear();
            _descriptionController.clear();
            _priorityController.clear();
            _dueDateController.clear();

            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void saveNewTask() {
    setState(() {
      toDoList.add({
        "title": _titleController.text,
        "description": _descriptionController.text,
        "priority": int.tryParse(_priorityController.text) ?? 1,
        "dueDate": DateTime.now(), // Replace with actual due date logic
        "completed": false,
      });

      // Clear controllers
      _titleController.clear();
      _descriptionController.clear();
      _priorityController.clear();
      _dueDateController.clear();
    });

    Navigator.of(context).pop();
  }

  void editTask(int index) {
    // Set controllers with existing values for editing
    _titleController.text = toDoList[index]["title"];
    _descriptionController.text = toDoList[index]["description"];
    _priorityController.text = toDoList[index]["priority"].toString();
    _dueDateController.text = toDoList[index]["dueDate"].toString();

    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          titleController: _titleController,
          descriptionController: _descriptionController,
          priorityController: _priorityController,
          dueDateController: _dueDateController,
          onSave: () {
            // Update existing task with new values
            setState(() {
              toDoList[index]["title"] = _titleController.text;
              toDoList[index]["description"] = _descriptionController.text;
              toDoList[index]["priority"] =
                  int.tryParse(_priorityController.text) ?? 1;
              toDoList[index]["dueDate"] =
                  DateTime.now(); // Replace with actual due date logic
            });

            // Clear controllers
            _titleController.clear();
            _descriptionController.clear();
            _priorityController.clear();
            _dueDateController.clear();

            Navigator.of(context).pop();
          },
          onCancel: () {
            // Clear controllers on cancel
            _titleController.clear();
            _descriptionController.clear();
            _priorityController.clear();
            _dueDateController.clear();

            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  List<Map<String, dynamic>> filteredTasks() {
    final searchTerm = _searchController.text.toLowerCase();
    return toDoList
        .where((task) =>
            task["title"].toLowerCase().contains(searchTerm) ||
            task["description"].toLowerCase().contains(searchTerm))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Background color
      appBar: AppBar(
        title: Text(
          'ToDo App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 130, 198, 82), // App bar color
        actions: [
          // Search icon and input field
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {}); // Trigger a rebuild
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.green, // FAB color
      ),
      body: ListView.builder(
        itemCount: filteredTasks().length,
        itemBuilder: (context, index) {
          final task = filteredTasks()[index];
          return ToDoTile(
            title: task["title"],
            description: task["description"],
            priority: task["priority"],
            dueDate: task["dueDate"],
            taskCompleted: task["completed"],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            editFunction: (context) => editTask(index),
          );
        },
      ),
    );
  }
}
