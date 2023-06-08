import 'package:flutter/material.dart';
import 'package:todo_list/screen/add_screen.dart';
import 'package:todo_list/screen/notes_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> _notes = [];

  void _addNote() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddScreen()),
    );

    if (result != null) {
      setState(() {
        _notes.add(result);
      });
    }
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: _notes.isEmpty
          ? Center(
              child: Text('No notes found.'),
            )
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return NotesCard(
                  title: _notes[index]['title']!,
                  content: _notes[index]['content']!,
                  onDelete: () => _deleteNote(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: Icon(Icons.add),
      ),
    );
  }
}
