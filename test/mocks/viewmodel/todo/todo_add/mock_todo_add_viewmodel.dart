import 'package:flutter/cupertino.dart';
import 'package:flutter_template/features/todo/viewmodels/todo_add_viewmodel.dart';
import 'package:mockito/mockito.dart';

class MockTodoAddViewModel extends Mock with ChangeNotifier implements TodoAddViewModel {}
