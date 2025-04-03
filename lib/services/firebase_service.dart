import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get the current user's UID
  String get currentUserId => _auth.currentUser!.uid;

  // Fetch tasks
  Stream<List<Task>> fetchTasks() {
    return _firestore
        .collection('tasks')
        .where('uid', isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Task.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  // Add a new task
  Future<void> addTask(String title, String description) async {
    await _firestore.collection('tasks').add({
      'uid': currentUserId,
      'title': title,
      'description': description,
      'isCompleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Update an existing task
  Future<void> updateTask(String taskId, String title, String description) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'title': title,
      'description': description,
    });
  }

  // Update task completion status
  Future<void> updateTaskStatus(String taskId, bool isCompleted) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'isCompleted': isCompleted,
    });
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }
}
