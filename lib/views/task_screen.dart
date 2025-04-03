import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../controllers/auth_controller.dart';
import '../models/task_model.dart';
import 'add_task_screen.dart';


class TaskScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () => _confirmLogout(),
          ),
        ],
      ),
      body: Obx(() {
        if (taskController.tasks.isEmpty) {
          return Center(
            child: Text(
              "No tasks found. Add your first task!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                title: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
                subtitle: Text(task.description, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                trailing: Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    activeColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    value: task.isCompleted,
                    onChanged: (val) {
                      taskController.updateTaskStatus(task.id, val!);
                    },
                  ),
                ),
                onLongPress: () => _showTaskOptions(task),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => Get.dialog(AddTaskScreen()),
        child: Icon(Icons.add, color: Colors.white),
      ),
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

  void _showTaskOptions(Task task) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: Colors.blueAccent),
              title: Text("Edit Task", style: TextStyle(fontSize: 18)),
              onTap: () {
                Get.back();
                _editTask(task);
              },
            ),
            Divider(height: 1, color: Colors.grey[300]),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.redAccent),
              title: Text("Delete Task", style: TextStyle(fontSize: 18)),
              onTap: () {
                Get.back();
                _confirmDeleteTask(task.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteTask(String taskId) {
    Get.defaultDialog(
      title: "Delete Task",
      middleText: "Are you sure you want to delete this task?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        taskController.deleteTask(taskId);
        Get.back();
      },
    );
  }
  
void _editTask(Task task) {
  TextEditingController editTitleController =
      TextEditingController(text: task.title);
  TextEditingController editDescriptionController =
      TextEditingController(text: task.description);

  Get.defaultDialog(
    title: "Edit Task",
    content: Column(
      children: [
        TextField(
          controller: editTitleController,
          decoration: _inputDecoration("Task Title", Icons.title),
        ),
        SizedBox(height: 10),
        TextField(
          controller: editDescriptionController,
          maxLines: 3,
          decoration: _inputDecoration("Task Description", Icons.description),
        ),
      ],
    ),
    textConfirm: "Update",
    textCancel: "Cancel",
    confirmTextColor: Colors.white,
    onConfirm: () {
      if (editTitleController.text.trim().isEmpty ||
          editDescriptionController.text.trim().isEmpty) {
        Get.snackbar("Error", "Title and Description cannot be empty");
        return;
      }
      taskController.updateTask(
        task.id,
        editTitleController.text.trim(),
        editDescriptionController.text.trim(),
      );
      Get.back();
    },
  );
}


  void _confirmLogout() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        authController.logout();
        Get.back();
      },
    );
  }
}
