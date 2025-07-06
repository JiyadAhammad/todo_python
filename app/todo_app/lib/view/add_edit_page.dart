import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model/todo_model.dart';

class AddEditPage extends StatefulWidget {
  const AddEditPage({super.key, required this.action, this.todoId});
  final TodoAction action;
  final TodoModel? todoId;

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  late final TextEditingController _headController;
  late final TextEditingController _desController;

  @override
  void initState() {
    super.initState();
    if (widget.action == TodoAction.edit) {
      _headController = TextEditingController(text: widget.todoId!.heading);
      _desController = TextEditingController(text: widget.todoId!.description);
    } else {
      _headController = TextEditingController();
      _desController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _headController.dispose();
    _desController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.action == TodoAction.add ? 'Add new Todo' : "Edit Todo",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 25,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter the Todo heading',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.greenAccent),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
            ),

            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter the description',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.greenAccent),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: TextButton(
          onPressed: () {
            if (widget.action == TodoAction.add) {
              // Create new todo logic
            } else {
              // update Existing todo
              // todo id needed to edit
            }
          },
          child: Text(widget.action == TodoAction.add ? 'Create' : "Update"),
        ),
      ),
    );
  }
}
