import 'package:todo_app/services/todo_services.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/add.dart';
import 'package:todo_app/utils/snack_bar_helper.dart';
import 'package:todo_app/widgets/todo_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  List items = [];
  late bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo App"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add ToDo'),
        onPressed: () => route_to_Addpage(context),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                "Nothing ToDo Wohoo",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                return ToDoCard(
                    index: index,
                    item: item,
                    navigate_to_Edit: route_to_Editpage,
                    deleteById: deleteToDo);
              },
            ),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> deleteToDo(String id) async {
    final isSuccess = await ToDoService().deleteToDo(id);

    if (isSuccess) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      setState(() {
        showFailureMessage(context, 'Deletion Failed');
      });
    }
  }

  Future<void> fetchTodo() async {
    setState(() {
      isLoading = true;
    });
    // ignore: non_constant_identifier_names
    final Fetched = await ToDoService().fetchToDo();
    if (Fetched != null) {
      setState(() {
        items = Fetched;
      });
    } else {
      // ignore: use_build_context_synchronously
      showFailureMessage(context, 'Error Getting Data');
    }
    setState(() {
      isLoading = false;
    });
  }

  // ignore: non_constant_identifier_names
  Future<void> route_to_Addpage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (context) => const AddToDo());
    await Navigator.push(context, route);
    setState(() {
      fetchTodo();
    });
  }

  // ignore: non_constant_identifier_names
  Future<void> route_to_Editpage(Map? todo) async {
    final route = MaterialPageRoute(
        builder: (context) => AddToDo(
              todo: todo,
            ));
    await Navigator.push(context, route);
    setState(() {
      fetchTodo();
    });
  }
}
