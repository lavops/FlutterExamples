import 'package:flutter/material.dart';
import 'package:gsheets_example/pages/expenses_page.dart';
import 'package:gsheets_example/pages/notes_page.dart';
import 'package:gsheets_example/pages/todos_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<StatefulWidget> _pages = [
    NotesPage(),
    TodosPage(),
    ExpensesPage(),
  ];

  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      label: "Notes",
      icon: Icon(Icons.note),
    ),
    BottomNavigationBarItem(
      label: "Todo's",
      icon: Icon(Icons.check_box),
    ),
    BottomNavigationBarItem(
      label: "Expenses",
      icon: Icon(Icons.money),
    ),
  ];

  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: _items,
      ),
      body: _pages.elementAt(_currentIndex),
    );
  }
}
