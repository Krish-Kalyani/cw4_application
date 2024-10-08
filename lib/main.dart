import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manage Tasks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TaskListScreen(),
    );
  }
}

class Task {
  String name;
  bool isCompleted;
  Task({required this.name, this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});
  @override
  TaskListScreenState createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen> {
  List<Task> taskList = [];
  TextEditingController taskController = TextEditingController();

  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        taskList.add(Task(name: taskController.text));
        taskController.clear();
      });
    }
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      taskList[index].isCompleted = !taskList[index].isCompleted;
    });
  }

  void deleteTask(int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Your Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: addTask,
                  child: const Text('Add Task'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: taskList[index].isCompleted,
                      onChanged: (value) {
                        toggleTaskCompletion(index);
                      },
                    ),
                    title: Text(
                      taskList[index].name,
                      style: TextStyle(
                        decoration: taskList[index].isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () => deleteTask(index),
                      child: const Text('Delete'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
