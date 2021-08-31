import 'package:gsheets/gsheets.dart';

import 'gsheets_credentials.secret.dart';

class GSheetsApi {
  static final _gsheets = GSheets(credentials);
  static Worksheet? _worksheetNotes;
  static Worksheet? _worksheetTodos;
  static Worksheet? _worksheetExpenses;

  // NOTES
  static int numberOfNotes = 0;
  static List<String> currentNotes = [];
  static bool loadingNotes = true;
  // TO-DOs
  static int numberOfTodos = 0;
  static List<List<dynamic>> currentTodos = [];
  static bool loadingTodos = true;
  // Expenses
  static int numberOfExpenses = 0;
  static List<List<dynamic>> currentExpenses = [];
  static bool loadingExpenses = true;

  Future init() async {
    final ss = await _gsheets.spreadsheet(spreadsheetID);
    _worksheetNotes = ss.worksheetByTitle('NOTES');
    _worksheetTodos = ss.worksheetByTitle('TODOs');
    _worksheetExpenses = ss.worksheetByTitle('EXPENSES');
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

  // Expenses
  static Future countRowsExpenses() async {
    while ((await _worksheetExpenses!.values
            .value(column: 1, row: numberOfExpenses + 1)) !=
        '') {
      numberOfExpenses++;
    }

    // Load all notes
    loadExpenses();
  }

  static Future loadExpenses() async {
    if (_worksheetExpenses == null) return;

    for (int i = 0; i < numberOfExpenses; i++) {
      final String transactionName =
          await _worksheetExpenses!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheetExpenses!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheetExpenses!.values.value(column: 3, row: i + 1);

      if (currentExpenses.length < numberOfExpenses) {
        currentExpenses.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }

    loadingExpenses = false;
  }

  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheetExpenses == null) return;

    numberOfExpenses++;
    currentExpenses.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);

    await _worksheetExpenses!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentExpenses.length; i++) {
      if (currentExpenses[i][2] == 'income') {
        totalIncome += double.parse(currentExpenses[i][1]);
      }
    }
    return totalIncome;
  }

  static double calculateExpense() {
    double totalIncome = 0;
    for (int i = 0; i < currentExpenses.length; i++) {
      if (currentExpenses[i][2] == 'expense') {
        totalIncome += double.parse(currentExpenses[i][1]);
      }
    }
    return totalIncome;
  }
}
