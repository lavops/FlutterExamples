import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/note_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _db = null;

  DatabaseHelper._instance();

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
    }

    return _db;
  }

  Future<Database?> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'database.db';

    final database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return database;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDate DATETIME, $colPriority TEXT, $colStatus INTEGER',
    );
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(noteTable);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    final List<Map<String, dynamic>> noteMapList = await getNoteMapList();

    final List<Note> noteList = [];

    noteMapList.forEach((noteMap) {
      noteList.add(Note.fromMap(noteMap));
    });

    noteList.sort((noteA, noteB) => noteA.date!.compareTo(noteB.date!));

    return noteList;
  }

  Future<int> insertNote(Note note) async {
    Database? db = await this.db;

    final int result = await db!.update(
      noteTable,
      note.toMap(),
      where: '$colId = ?',
      whereArgs: [note.id],
    );

    return result;
  }

  Future<int> updateNote(Note note) async {
    Database? db = await this.db;

    final int result = await db!.update(
      noteTable,
      note.toMap(),
      where: '$colId = ?',
      whereArgs: [note.id],
    );

    return result;
  }

  Future<int> deleteNote(Note note) async {
    Database? db = await this.db;

    final int result = await db!.delete(
      noteTable,
      where: '$colId = ?',
      whereArgs: [note.id],
    );

    return result;
  }
}
