import 'package:flutter/material.dart';
import 'package:tdd/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:tdd/features/year_trivia/presentation/pages/year_trivia_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: YearTriviaPage(),
    );
  }
}
