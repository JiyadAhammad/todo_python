import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/service/todo_service.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService _todoService;
  TodoBloc(this._todoService) : super(TodoInital()) {
    on<CreateTodo>(createNewTodo);
    on<GetTodo>(getTodo);
    on<UpdateTodo>(updateTodo);
    on<DeleteTodo>(deleteTodo);
  }

  Future<void> createNewTodo(CreateTodo event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      final res = await _todoService.createNewTodo(event.todo);
      res.fold(
        (l) => log(l.failureMessage, name: 'createNewTodo Fetch Error'),
        (r) {
          // Show snackbar to user
          add(GetTodo());
        },
      );
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  Future<void> getTodo(GetTodo event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      final allTodoList = await _todoService.getAllTodo();
      allTodoList.fold((l) => log(l.failureMessage, name: 'Fetch todo Error'), (
        r,
      ) {
        r.sort((a, b) => int.parse(b.id!).compareTo(int.parse(a.id!)));
        emit(TodoLoaded(todoList: r));
      });
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  Future<void> updateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      final result = await _todoService.updateNewTodo(event.todo);
      result.fold((l) => log(l.failureMessage, name: 'Update todo Error'), (r) {
        // Show snackbar to user
        add(GetTodo());
      });
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  Future<void> deleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      final result = await _todoService.deleteTodo(event.todoId);
      result.fold((l) => log(l.failureMessage, name: 'Update todo Error'), (r) {
        // Show snackbar to user
        add(GetTodo());
      });
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }
}
