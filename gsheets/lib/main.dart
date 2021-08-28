import 'package:flutter/material.dart';
import 'package:gsheets_example/services/gsheets_api.dart';
import 'package:gsheets_example/pages/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GSheetsApi().init();

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
      home: HomePage(),
    );
  }
}
