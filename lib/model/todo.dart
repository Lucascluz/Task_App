import 'dart:html';

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  List<ToDo> todoList() {
    return [
      ToDo(id: "01", todoText: "Check Mail", isDone: true),
      ToDo(id: "02", todoText: "Play games", isDone: true),
      ToDo(id: "03", todoText: "Be cool", isDone: false),
      ToDo(id: "04", todoText: "Run fast", isDone: false),
      ToDo(id: "05", todoText: "Be handsome", isDone: false),
    ];
  }
}
