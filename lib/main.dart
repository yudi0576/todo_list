import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class Todo {
  String id;
  String task;
  bool completed;

  Todo({
    required this.id,
    required this.task,
    required this.completed,
  });
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Nama Kelompok 2',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> _todoItems = [];
  TextEditingController _textEditingController = TextEditingController();

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        final newTodo = Todo(
          id: DateTime.now().toString(),
          task: task,
          completed: false,
        );
        _todoItems.add(newTodo);
      });
      _textEditingController.clear();
    }
  }

  void _updateTodoItem(String id, String updatedTask) {
    setState(() {
      final todo = _todoItems.firstWhere((item) => item.id == id);
      todo.task = updatedTask;
    });
  }

  void _toggleTodoItem(String id) {
    setState(() {
      final todo = _todoItems.firstWhere((item) => item.id == id);
      todo.completed = !todo.completed;
    });
  }

  void _removeTodoItem(String id) {
    setState(() {
      _todoItems.removeWhere((item) => item.id == id);
    });
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        final todo = _todoItems[index];
        return ListTile(
          title: Text(
            todo.task,
            style: TextStyle(
              decoration: todo.completed
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _showEditDialog(todo);
                },
              ),
              IconButton(
                icon: Icon(Icons.check_box),
                onPressed: () {
                  _toggleTodoItem(todo.id);
                },
                color: todo.completed ? Colors.green : Colors.grey,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _removeTodoItem(todo.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditDialog(Todo todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController controller =
            TextEditingController(text: todo.task);

        return AlertDialog(
          title: Text('Masukan Data '),
          content: TextField(
            controller: controller,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _updateTodoItem(todo.id, controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Kelompok'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildTodoList(),
          ),
          Divider(),
          ListTile(
            title: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Masukan data',
              ),
              onSubmitted: (value) {
                _addTodoItem(value);
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addTodoItem(_textEditingController.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}

