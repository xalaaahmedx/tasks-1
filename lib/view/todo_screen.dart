import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:welcome/model/todo_model.dart';
import 'package:welcome/service/service.dart';
import 'package:welcome/view/cubit/todo_cubit.dart';

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
        body: BlocProvider(
          create: (context) => TodoCubit(),
          child: BlocConsumer<TodoCubit, TodoState>(
            listener: (context, state) {
              if (state is TodoLoading) {
                print("Loading");
              }
            },
            builder: (context, state) {
              return state is TodoLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : state is TodoSuccess
                      ? ListView.builder(
                          itemCount: context.watch<TodoCubit>().users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(todos[index].title ?? "--"),
                            );
                          },
                        )
                      : const Center(
                          child: Text("Error"),
                        );
            },
          ),
        ));
  }
}
