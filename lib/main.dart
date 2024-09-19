import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Aoi ( ͡~ ͜ʖ ͡°)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List (◑‿◐)'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          return ListView.builder(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              final todo = todoProvider.todos[index];
              return ListTile(
                title: Text(todo.title),
                leading: Checkbox(
                  value: todo.completed,
                  onChanged: (_) => todoProvider.toggleTodo(todo.id),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => todoProvider.removeTodo(todo.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTodoDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddTodoDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task (ᵖʳᵉᵗᵗʸ ᵖˡᵉᵃˢᵉ)'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: 'Enter task title '),
      ),//🍔ԅ( ͒ ۝ ͒ )
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              Provider.of<TodoProvider>(context, listen: false)
                  .addTodo(_controller.text);
              Navigator.pop(context);
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}