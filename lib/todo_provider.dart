import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    final newTodo = Todo(id: Uuid().v4(), title: title);
    _todos.add(newTodo);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      _todos[todoIndex].completed = !_todos[todoIndex].completed;
      notifyListeners();
    }
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}