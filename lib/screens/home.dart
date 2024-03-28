import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/widgets/task_item.dart';

import '../model/task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Task.taskList();
  List<Task> _foundTasks = Task.taskList();
  final _taskController = TextEditingController();

  @override
  void initState() {
    _foundTasks = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGColor,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        padding: const EdgeInsets.only(left: 40, bottom: 20),
                        child: const Text("Tasks",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600)),
                      ),
                      for (Task task in _foundTasks.reversed)
                        TaskItem(
                          task: task,
                          onTaskChanged: _handleTaskChange,
                          onDeleteItem: _handleDeleteItem,
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
          taskCreator()
        ],
      ),
    );
  }

  void _handleTaskChange(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void _handleDeleteItem(String id) {
    setState(() {
      todosList.removeWhere((element) => element.id == id);
    });
  }

  void _handleAddItem(String taskText) {
    setState(() {
      todosList.add(Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          taskText: taskText));
    });
    _taskController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Task>? results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((element) =>
              element.taskText!.toLowerCase().contains(enteredKeyword))
          .toList();
    }

    setState(() {
      _foundTasks = results!;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(Icons.search, color: Colors.black, size: 25),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, minWidth: 25),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 99, 99, 99),
              ))),
    );
  }

  Widget taskCreator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _taskController,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    _handleAddItem(value);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          title: Text("Campo vazio!"),
                          content:
                              Text("Não é possível criar tarefas sem nome!"),
                        );
                      },
                    );
                  }
                },
                decoration: const InputDecoration(
                    hintText: "Add a new task", border: InputBorder.none),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  _handleAddItem(_taskController.text);
                } else {
                  AlertDialog alerta = const AlertDialog(
                    title: Text("Campo vazio!"),
                    content: Text("Não é possível criar tarefas sem nome!"),
                  );

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alerta;
                      });
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  minimumSize: const Size(10, 10),
                  elevation: 10),
              child: const Text(
                "+",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: BGColor,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(onPressed: () {
          
        }, icon: const Icon(Icons.menu))
      ]),
    );
  }
}
