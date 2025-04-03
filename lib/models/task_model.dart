class Task {
  String id;
  String title;
  String description;
  bool isCompleted;
  String uid; 

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.uid, 
  });

  factory Task.fromMap(String id, Map<String, dynamic> data) {
    return Task(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      uid: data['uid'] ?? '', 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'uid': uid, 
    };
  }
}
