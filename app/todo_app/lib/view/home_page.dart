import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/view/add_edit_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoBloc>().add(GetTodo());
    });
    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            log(state.message);
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is TodoLoaded) {
            if (state.todoList.isEmpty) {
              return Center(child: Text('No Item found'));
            }
            return GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: state.todoList.length,
              itemBuilder: (BuildContext context, int index) {
                final data = state.todoList[index];
                return GestureDetector(
                  onLongPress: () {
                    // Option for Edit or delete

                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return SizedBox(
                          height: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Edit Logic
                                  Navigator.pop(ctx);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEditPage(
                                        action: TodoAction.edit,
                                        todo: data,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit, size: 50),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Delete logic
                                  if (data.id == null) {
                                    return;
                                  }
                                  context.read<TodoBloc>().add(
                                    DeleteTodo(todoId: data.id!),
                                  );
                                  Navigator.pop(ctx);
                                },
                                icon: Icon(Icons.delete, size: 50),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data.title ?? 'No title',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: Text(
                            data.description ?? 'No Description',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Add new Todo
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditPage(action: TodoAction.add),
            ),
          );
        },
      ),
    );
  }
}
