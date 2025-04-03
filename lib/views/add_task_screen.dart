import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return AlertDialog(
      title: Text("Add Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: _inputDecoration("Task Title", Icons.title),
          ),
          SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            maxLines: 3, 
            decoration: _inputDecoration("Task Description", Icons.description),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (titleController.text.trim().isEmpty ||
                descriptionController.text.trim().isEmpty) {
              Get.snackbar("Error", "Title and Description cannot be empty");
              return;
            }
            taskController.addTask(
              titleController.text.trim(),
              descriptionController.text.trim(),
            );
            Get.back();
          },
          child: Text("Add"),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
