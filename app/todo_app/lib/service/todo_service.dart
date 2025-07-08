import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../model/failure.dart';
import '../model/todo_model.dart';

class TodoService {
  Future<Either<Error, bool>> createNewTodo(TodoModel todo) async {
    try {
      final url = Uri.parse('${Config.baseUrl}${Config.createNewTodo}');

      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id": todo.id,
          "title": todo.title,
          "descrption": todo.description,
        }),
      );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return right(true);
      } else if (res.statusCode >= 400 && res.statusCode <= 499) {
        return left(ClientError(failureMessage: data['Message']));
      } else {
        return left(ServerError(failureMessage: data.toString()));
      }
    } catch (e) {
      log('catc createNewTodo $e');
      return left(ClientError(failureMessage: e.toString()));
    }
  }

  Future<Either<Error, List<TodoModel>>> getAllTodo() async {
    try {
      final url = Uri.parse('${Config.baseUrl}${Config.getAllTodo}');

      final res = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      log(res.body);

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return right(TodoModel.fromList(data['data']));
      } else if (res.statusCode >= 400 && res.statusCode <= 499) {
        return left(ClientError(failureMessage: data['Message']));
      } else {
        return left(ServerError(failureMessage: data.toString()));
      }
    } catch (e) {
      log('catc getAllTodo $e');
      return left(ServerError(failureMessage: e.toString()));
    }
  }

  Future<Either<Error, bool>> updateNewTodo(TodoModel todo) async {
    try {
      final url = Uri.parse('${Config.baseUrl}${Config.updateTodo}');

      final res = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id": todo.id,
          "title": todo.title,
          "descrption": todo.description,
        }),
      );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return right(true);
      } else if (res.statusCode >= 400 && res.statusCode <= 499) {
        return left(ClientError(failureMessage: data['Message']));
      } else {
        return left(ServerError(failureMessage: data.toString()));
      }
    } catch (e) {
      log('catc createNewTodo $e');
      return left(ClientError(failureMessage: e.toString()));
    }
  }

  Future<Either<Error, bool>> deleteTodo(String todoId) async {
    try {
      final url = Uri.parse('${Config.baseUrl}${Config.deleteTodo}/$todoId');

      final res = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return right(true);
      } else if (res.statusCode >= 400 && res.statusCode <= 499) {
        return left(ClientError(failureMessage: data['Message']));
      } else {
        return left(ServerError(failureMessage: data.toString()));
      }
    } catch (e) {
      log('catc createNewTodo $e');
      return left(ClientError(failureMessage: e.toString()));
    }
  }
}
