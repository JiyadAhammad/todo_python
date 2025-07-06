import 'dart:convert';
import 'dart:developer';

import 'package:todo_app/config.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/model/todo_model.dart';

class TodoService {
  Future<bool> createNewTodo(TodoModel data) async {
    log('Call reached here');
    try {
      final url = Uri.parse('${Config.baseUrl}${Config.createNewTodo}');

      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id": "1",
          "title": "first title",
          "descrption": "First description",
        }),
      );

      log(res.body, name: 'api response');
      if (res.statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {
      log('catc $e');
      return false;
    }
  }
}
