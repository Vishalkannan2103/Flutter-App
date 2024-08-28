import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'api/api_services.dart';
// import '../model/todo.dart';

class ToDoController extends GetxController {
  Rx<bool> todoLoaded = false.obs;

  Rx<bool> calendar = false.obs;

  final search = ''.obs;

  final lableCreateKey = GlobalKey<FormState>();

  // Future<List<Todo>>? t;
  var todo = <Todo>[].obs;
  var filteredLabels = [].obs;
  Rx<CalendarFormat> format = CalendarFormat.month.obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  final refreshkey = GlobalKey();
  final taskFormKey = GlobalKey<FormState>();
  final createTodokey = GlobalKey<FormState>();

  final renamekey = GlobalKey<FormState>();

  final todoTitle = TextEditingController();

  final labelText = TextEditingController();
  var labels = [].obs;
  final Api api = Api();

  Future fetchAllTodo() async {
    try {
      final response = await api.fetchAllTodo(todoLoaded: todoLoaded);
      final data = json.decode(response);
      final jsonToDart = data["data"].cast<Map<String, dynamic>>();
      todo.value = jsonToDart.map<Todo>((json) {
        return Todo.fromJson(json);
      }).toList();
      todoLoaded.value = false;
      return todo;
    } catch (e) {
      print("error: $e");
    }
  }

  Future createTodo() async {
    try {
      await api.createTodo(
          todoTitle: todoTitle.text, filteredLabels: filteredLabels);
      filteredLabels.value = [];

      fetchAllTodo();
      Get.back();
      todoTitle.clear();
    } catch (e) {
      print("error: $e");
    }
  }

  Future createTask(id, TextEditingController title) async {
    try {
      await api.createTask(id: id, title: title.text);
      fetchAllTodo();
      title.clear();
    } catch (e) {
      print("error: $e");
    }
  }

  Future deleteTodo(id) async {
    try {
      await api.deleteTodo(id: id);
      fetchAllTodo();
      Get.back();
    } catch (e) {
      print("error: $e");
    }
  }

  Future updateTaskStatus(id, tid, bool? complete) async {
    try {
      await api.updateTaskStatus(id: id, tid: tid, complete: complete);
      fetchAllTodo();
    } catch (e) {
      print("error: $e");
    }
  }

  Future deleteTask(id, tid) async {
    try {
      await api.deleteTask(id: id, tid: tid);
      fetchAllTodo();
      Get.back();
    } catch (e) {
      print("error: $e");
    }
  }

  Future renameTodo(id) async {
    try {
      await api.renameTodo(id: id, todoTitle: todoTitle.text);
      fetchAllTodo();
      todoTitle.clear();
      Get.back();
    } catch (e) {
      print("error: $e");
    }
  }

  Future fetchAllLabels() async {
    try {
      final response = await api.fetchAllLabels();
      final data = json.decode(response);
      labels.value = data['data']['labels'];
      return labels;
    } catch (e) {
      print("error: $e");
    }
  }

  Future createLabel() async {
    try {
      await api.createLabel(labelText: labelText.text);
      fetchAllLabels();
      labelText.clear();
    } catch (e) {
      print("error: $e");
    }
  }

  Future deleteLabel(label) async {
    try {
      await api.deleteLabel(lable: label);
      fetchAllLabels();
      fetchAllTodo();
      Get.back();
    } catch (e) {
      print("error: $e");
    }
  }

  Future updateLabel(id, label) async {
    try {
      await api.updateLabel(lable: label, id: id);
      fetchAllTodo();
      filteredLabels.clear();
      Get.back();
    } catch (e) {
      print("error: $e");
    }
  }
}
