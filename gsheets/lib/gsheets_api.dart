import 'package:gsheets/gsheets.dart';

import 'gsheets_credentials.secret.dart';

class GSheetsApi {
  static final _gsheets = GSheets(credentials);
  static Worksheet? _worksheet;

  Future init() async {
    final ss = await _gsheets.spreadsheet(spreadsheetID);
    _worksheet = ss.worksheetByTitle('Proba');
  }
}
