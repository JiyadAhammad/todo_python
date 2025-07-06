import 'package:flutter/material.dart';

import 'view/home_page.dart';

enum TodoAction { add, edit }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Demo',
      theme: ThemeData().copyWith(scaffoldBackgroundColor: Colors.white),
      home: const HomePage(),
    );
  }
}
