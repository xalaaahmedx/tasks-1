import 'package:welcome/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:welcome/service/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial()) {
    getUsers();
  }
  List<Welcome> users = [];

  getUsers() async {
    try {
      emit(TodoLoading());
      users = await ToDo().getTodos();
      emit(TodoSuccess());
    } catch (e) {
      print(e.toString());
      emit(TodoError());
    }
  }
}
