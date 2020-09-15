import 'package:flutter_template/models/networking/todo.dart';

// ignore: one_member_abstracts
abstract class TodoService {
  Future<List<Todo>> getTodos();
}
