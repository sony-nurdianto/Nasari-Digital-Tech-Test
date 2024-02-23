import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:nadi_flutter_test/repository/models/todo_models.dart';

class TodoData {

  static String apiUri = 'https://65d78ca127d9a3bc1d7b4ad6.mockapi.io/task';

  Future<dynamic> getDataTodo() async {
    try {
      List<TodoModels> todoModels = [];
      final response = await http
          .get(Uri.parse(apiUri));
      final dataJson = json.decode(response.body);

      for (var item in dataJson) {
        TodoModels data = TodoModels.fromJson(item);
        todoModels.add(data);
      }

      return todoModels;
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<dynamic> inputDataTodo(TodoModels data) async {
    try {
      final response = await http.post(
          Uri.parse(apiUri),
          headers: {"Content-Type": "application/json"},
          body: json.encode(data.toJson()));

      return response;
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<dynamic> updateDataTodo(TodoModels data) async {
    try {
      final response = await http.put(
          Uri.parse(
              '$apiUri/${data.id}'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(data.toJson()));

      return response;
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<dynamic> deleteDataTodo(String id) async {
    try {
      final response = await http.delete(
        Uri.parse(
            '$apiUri/$id'),
        headers: {"Content-Type": "application/json"},
      );
      return response;
    } catch (e) {
      debugPrint('$e');
    }
  }
}
