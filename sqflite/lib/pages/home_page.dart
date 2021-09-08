import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_demo/database/database.dart';
import 'package:sqflite_demo/models/note_model.dart';
import 'package:sqflite_demo/pages/new_note_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Note>> _noteList;
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  _updateNoteList() {
    _noteList = _databaseHelper.getNoteList();
  }

  @override
  void initState() {
    super.initState();
    _updateNoteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(),
      body: buildBody(),
    );
  }

  buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NewNotePage(
              updateNoteList: _updateNoteList,
            ),
          ),
        );
      },
    );
  }

  buildBody() {
    return FutureBuilder(
      future: _noteList,
      builder: (context, AsyncSnapshot snapshot) {
        print(snapshot.hasData);
        print(snapshot.data);

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final int completeNoteCount = snapshot.data!
            .where((Note note) => note.status == 1)
            .toList()
            .length;

        return ListView.builder(
          itemCount: int.parse(snapshot.data!.length.toString()) + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Notes',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$completeNoteCount of ${snapshot.data.length}',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }
            return buildNote(snapshot.data![index - 1]);
          },
        );
      },
    );
  }

  buildNote(Note note) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              note.title!,
              style: TextStyle(
                fontSize: 18,
                // color: Colors.white,
                decoration: note.status == 0
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
              ),
            ),
            subtitle: Text(
              '${_dateFormatter.format(note.date!)} - ${note.priority}',
              style: TextStyle(
                fontSize: 15,
                decoration: note.status == 0
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
              ),
            ),
            trailing: Checkbox(
              onChanged: (value) {
                note.status = value! ? 1 : 0;
                DatabaseHelper.instance.updateNote(note);
                _updateNoteList();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(),
                  ),
                );
              },
              activeColor: Theme.of(context).primaryColor,
              value: note.status == 1 ? true : false,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NewNotePage(
                  note: note,
                  updateNoteList: _updateNoteList,
                ),
              ),
            ),
          ),
          Divider(
            height: 5,
            color: Colors.deepPurple,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
