import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:gsheets_example/gsheets_credentials.secret.dart';

void main() async {
  final gsheets = GSheets(credentials);
  final ss = await gsheets.spreadsheet(spreadsheetID);
  var sheet = ss.worksheetByTitle('Proba');
  await sheet!.values.insertValue('Proba', column: 1, row: 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GSheets Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
