import 'package:flutter/material.dart';
import 'package:todo_app/services/todo_services.dart';
import 'package:todo_app/utils/snack_bar_helper.dart';

class AddToDo extends StatefulWidget {
  final Map? todo;
  const AddToDo({super.key, this.todo});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      title.text = todo['title'];
      description.text = todo['description'];
    }
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          isEdit ? "EDIT Page" : "ADD Page",
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: title,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: "Title",
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: description,
            minLines: 5,
            maxLines: 8,
            decoration: const InputDecoration(
              hintText: "Description",
            ),
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              child: Text(isEdit ? "Update" : "Submit",
                  style: const TextStyle(color: Colors.white, fontSize: 15))),
        ],
      ),
    );
  }

  void submitData() async {
    // Get data from the server.
    final ttl = title.text;
    final desc = description.text;
    final body = {"title": ttl, "description": desc, "is_completed": false};
    // Submit data to the server.
    final isSuccess = await ToDoService().addToDo(body);
    // Show success feedback to the user.
    if (isSuccess) {
      title.text = '';
      description.text = '';
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, "Created SuccessFully");
    } else {
      // ignore: use_build_context_synchronously
      showFailureMessage(context, "Creation Failed");
    }
  }

  Future<void> updateData() async {
    // Get data from the server.

    final ttl = title.text;
    final desc = description.text;
    final id = widget.todo?['_id'];
    final body = {"title": ttl, "description": desc, "is_completed": false};

    // Submit the updated data to the server.
    final isSuccess = await ToDoService().updateToDo(id, body);

    // Show success feedback to the user.
    if (isSuccess) {
      title.text = '';
      description.text = '';
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, "Updated SuccessFully");
    } else {
      // ignore: use_build_context_synchronously
      showFailureMessage(context, "Update Failed");
    }
  }
}
