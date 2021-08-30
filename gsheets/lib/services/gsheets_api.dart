import 'package:gsheets/gsheets.dart';

import 'gsheets_credentials.secret.dart';

class GSheetsApi {
  static final _gsheets = GSheets(credentials);
  static Worksheet? _worksheetNotes;
  static Worksheet? _worksheetTodos;

  // NOTES
  static int numberOfNotes = 0;
  static List<String> currentNotes = [];
  static bool loadingNotes = true;
  // TO-DOs
  static int numberOfTodos = 0;
  static List<List<dynamic>> currentTodos = [];
  static bool loadingTodos = true;

  Future init() async {
    final ss = await _gsheets.spreadsheet(spreadsheetID);
    _worksheetNotes = ss.worksheetByTitle('NOTES');
    _worksheetTodos = ss.worksheetByTitle('TODOs');
    // Count number of notes
    countRowsNotes();
    countRowsTodos();
  }

  // NOTES FUNCTIONS
  static Future countRowsNotes() async {
    while ((await _worksheetNotes!.values
            .value(column: 1, row: numberOfNotes + 1)) !=
        '') {
      numberOfNotes++;
    }

    // Load all notes
    loadNotes();
  }

  static Future loadNotes() async {
    if (_worksheetNotes == null) return;

    for (int i = 0; i < numberOfNotes; i++) {
      final String newNote =
          await _worksheetNotes!.values.value(column: 1, row: i + 1);

      if (currentNotes.length < numberOfNotes) {
        currentNotes.add(newNote);
      }
    }

    loadingNotes = false;
  }

  static Future insertNote(String note) async {
    if (_worksheetNotes == null) return;

    numberOfNotes++;
    currentNotes.add(note);
    await _worksheetNotes!.values.appendRow([note]);
  }

  // TO-DO FUNCTIONS
  static Future countRowsTodos() async {
    while ((await _worksheetTodos!.values
            .value(column: 1, row: numberOfTodos + 1)) !=
        '') {
      numberOfTodos++;
    }

    // Load all notes
    loadTodos();
  }

  static Future loadTodos() async {
    if (_worksheetTodos == null) return;

    for (int i = 0; i < numberOfTodos; i++) {
      final String newTodoString =
          await _worksheetTodos!.values.value(column: 1, row: i + 1);
      final int newTodoDone =
          int.parse(await _worksheetTodos!.values.value(column: 2, row: i + 1));
      if (currentTodos.length < numberOfTodos) {
        currentTodos.add([
          newTodoString,
          newTodoDone,
        ]);
      }
    }

    loadingTodos = false;
  }

  static Future insertTodo(String todo) async {
    if (_worksheetTodos == null) return;

    numberOfTodos++;
    currentTodos.add([todo, 0]);
    await _worksheetTodos!.values.appendRow([todo, 0]);
  }

  static Future updateTodo(int index, int isDone) async {
    _worksheetTodos!.values.insertValue(isDone, column: 2, row: index + 1);
  }
}
