part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class CreateTodo extends TodoEvent {
  final TodoModel todo;

  CreateTodo({required this.todo});
}

class GetTodo extends TodoEvent {}

class UpdateTodo extends TodoEvent {
  final TodoModel todo;

  UpdateTodo({required this.todo});
}

class DeleteTodo extends TodoEvent {
  final String todoId;

  DeleteTodo({required this.todoId});
}
