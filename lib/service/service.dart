
import 'package:dio/dio.dart';
import 'package:welcome/model/todo_model.dart';

class ToDo {
  String url = "https://jsonplaceholder.typicode.com/todos";

  Future<List<Welcome>> getTodos() async {
    List<Welcome> todos = [];
    Response response = await Dio().get(url);
    var data = response.data;
    data.forEach((element) {
      Welcome todo = Welcome.fromJson(element);
      todos.add(todo);
    });
    return todos;
  }
}