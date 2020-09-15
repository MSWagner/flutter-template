import 'package:flutter/cupertino.dart';
import 'package:flutter_template/models/networking/todo.dart';

abstract class TodoRepo {
  Stream<List<Todo>> getTodos();

  Future<List<Todo>> fetchTodos();

  Future<void> saveTodo(String todo);

  Future<void> setTodoState({@required int id, @required bool value});
}
