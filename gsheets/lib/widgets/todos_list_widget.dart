import 'package:flutter/material.dart';
import 'package:gsheets_example/services/gsheets_api.dart';

class TodosListWidget extends StatefulWidget {
  TodosListWidget({Key? key}) : super(key: key);

  @override
  _TodosListWidgetState createState() => _TodosListWidgetState();
}

class _TodosListWidgetState extends State<TodosListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: GSheetsApi.currentTodos.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: GSheetsApi.currentTodos[index][1] == 0
                  ? Colors.grey[200]
                  : Colors.grey[400],
              padding: EdgeInsets.all(15),
              child: CheckboxListTile(
                value: GSheetsApi.currentTodos[index][1] == 0 ? false : true,
                title: Text(
                  GSheetsApi.currentTodos[index][0],
                  style: TextStyle(
                    color: GSheetsApi.currentTodos[index][1] == 0
                        ? Colors.grey[800]
                        : Colors.grey[500],
                  ),
                ),
                onChanged: (newValue) {
                  GSheetsApi.updateTodo(index, newValue == false ? 0 : 1);
                  setState(() {
                    GSheetsApi.currentTodos[index][1] =
                        newValue == false ? 0 : 1;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
