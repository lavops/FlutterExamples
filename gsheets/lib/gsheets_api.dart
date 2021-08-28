import 'package:gsheets/gsheets.dart';

import 'gsheets_credentials.secret.dart';

class GSheetsApi {
  static final _gsheets = GSheets(credentials);
  static Worksheet? _worksheet;

  static int numberOfNotes = 0;
  static List<String> currentNotes = [];
  static bool loading = true;

  Future init() async {
    final ss = await _gsheets.spreadsheet(spreadsheetID);
    _worksheet = ss.worksheetByTitle('Proba');
    // Count number of notes
    countRows();
  }

  static Future countRows() async {
    while (
        (await _worksheet!.values.value(column: 1, row: numberOfNotes + 1)) !=
            '') {
      numberOfNotes++;
    }

    // Load all notes
    loadNotes();
  }

  static Future loadNotes() async {
    if (_worksheet == null) return;

    for (int i = 0; i < numberOfNotes; i++) {
      final String newNote =
          await _worksheet!.values.value(column: 1, row: i + 1);

      if (currentNotes.length < numberOfNotes) {
        currentNotes.add(newNote);
      }
    }

    loading = false;
  }

  static Future insert(String note) async {
    if (_worksheet == null) return;

    numberOfNotes++;
    currentNotes.add(note);
    await _worksheet!.values.appendRow([note]);
  }
}
