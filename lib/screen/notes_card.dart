import 'package:flutter/material.dart';
import 'package:todo_list/models/note.dart';

class NotesCard extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onDelete;

  const NotesCard({
    required this.title,
    required this.content,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(content),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
