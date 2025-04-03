import 'package:get/get.dart';
import '../models/task_model.dart';
import '../services/firebase_service.dart';

class TaskController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final RxList<Task> tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  // Fetch tasks and update the state
  void fetchTasks() {
    _firebaseService.fetchTasks().listen((taskList) {
      tasks.assignAll(taskList);
    });
  }

  Future<void> addTask(String title, String description) async {
    await _firebaseService.addTask(title, description);
  }

  Future<void> updateTask(String taskId, String title, String description) async {
    await _firebaseService.updateTask(taskId, title, description);
  }

  Future<void> updateTaskStatus(String taskId, bool isCompleted) async {
    await _firebaseService.updateTaskStatus(taskId, isCompleted);
  }

  Future<void> deleteTask(String taskId) async {
    await _firebaseService.deleteTask(taskId);
  }
}
