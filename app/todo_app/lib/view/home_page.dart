import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/view/add_edit_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   log('message');
    //   TodoService().createNewTodo(TodoModel());
    // });
    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: GridView.builder(
        padding: EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
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
                                  todoId: TodoModel(),
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit, size: 50),
                        ),
                        IconButton(
                          onPressed: () {
                            // Delete logic
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
                        'Todo Heading',
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
                      'Todo Description',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
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
