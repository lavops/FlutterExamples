import 'package:flutter/material.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';

class YearTriviaDisplay extends StatelessWidget {
  final YearTrivia trivia;
  const YearTriviaDisplay({Key key, @required this.trivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            Text(
              trivia.year.toString(),
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    trivia.text,
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
