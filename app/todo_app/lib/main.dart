import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/service/todo_service.dart';

import 'view/home_page.dart';

enum TodoAction { add, edit }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => TodoBloc(TodoService()))],
      child: MaterialApp(
        title: 'Todo Demo',
        theme: ThemeData().copyWith(scaffoldBackgroundColor: Colors.white),
        home: const HomePage(),
      ),
    );
  }
}
