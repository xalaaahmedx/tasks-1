import 'package:flutter/material.dart';
import 'package:welcome/model/todo_model.dart';
import 'package:welcome/service/service.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<Welcome> todos = [];
  bool isLoading = true;
  Future<void> getTodosFromApi() async {
    todos = await ToDo().getTodos();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTodosFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(todos[index].title ?? "--"),
                );
              },
            ),
    );
  }
}
