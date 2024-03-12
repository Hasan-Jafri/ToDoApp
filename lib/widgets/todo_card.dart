import 'package:flutter/material.dart';

class ToDoCard extends StatelessWidget {
  final int index;
  final Map item;
  // ignore: non_constant_identifier_names
  final Function(Map) navigate_to_Edit;
  final Function(String) deleteById;
  const ToDoCard(
      {super.key,
      required this.index,
      required this.item,
      // ignore: non_constant_identifier_names
      required this.navigate_to_Edit,
      required this.deleteById});

  @override
  Widget build(BuildContext context) {
    final id = item['_id'];
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Text("${index + 1}"),
        ),
        title: Text(
          item['title'],
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        subtitle: Text(
          item['description'],
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              navigate_to_Edit(item);
            } else if (value == 'delete') {
              deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: "edit",
                child: Text("Edit"),
              ),
              const PopupMenuItem(
                value: "delete",
                child: Text("Delete"),
              )
            ];
          },
        ),
      ),
    );
  }
}
