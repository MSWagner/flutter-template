import 'package:flutter/material.dart';
import 'package:flutter_template/features/debug/screens/debug_screen.dart';
import 'package:flutter_template/features/todo/screens/todo_list_screen.dart';
import 'package:flutter_template/util/locale/localization.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    return Scaffold(
      body: IndexedStack(
        children: const [
          TodoListScreen(),
          DebugScreen(),
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            title: Text(localization.todoTitle),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            title: Text(localization.settingsTitle),
          ),
        ],
      ),
    );
  }

  void _onTap(int newIndex) {
    setState(() => _currentIndex = newIndex);
  }
}