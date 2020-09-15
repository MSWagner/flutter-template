import 'package:flutter_template/models/networking/todo.dart';
import 'package:flutter_template/styles/theme_durations.dart';
import 'package:flutter_template/networking/api/dummy_api_util.dart';
import 'package:flutter_template/networking/todo/todo_service.dart';

class TodoDummyService extends TodoService {
  final todos = List<Todo>();

  @override
  Future<List<Todo>> getTodos() async {
    await Future.delayed(ThemeDurations.demoNetworkCallDuration());
    if (todos.isEmpty) {
      final result = await DummyApiUtil.getResponse<List<dynamic>>('todos');
      final newTodos = result.map((item) => Todo.fromJson(item)).toList();
      todos.addAll(newTodos);
    }
    return todos;
  }
}
