class Task {
  String? id;
  String? taskText;
  bool isDone;

  Task({required this.id, required this.taskText, this.isDone = false});

  static List<Task> taskList() {
    return [];
  }

  setTrue() {
    isDone = true;
  }

  setFalse() {
    isDone = false;
  }
}
