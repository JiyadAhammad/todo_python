import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBlocBloc extends Bloc<TodoBlocEvent, TodoBlocState> {
  TodoBlocBloc() : super(TodoBlocInitial()) {
    on<TodoBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
