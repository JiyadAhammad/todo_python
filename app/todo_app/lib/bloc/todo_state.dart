part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInital extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoModel> todoList;

  TodoLoaded({required this.todoList});
}

class TodoError extends TodoState {
  final String message;

  TodoError({required this.message});
}
