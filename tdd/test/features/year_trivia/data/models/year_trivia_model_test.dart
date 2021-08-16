import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/features/year_trivia/data/models/year_trivia_model.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tYearTriviaModel = YearTriviaModel(text: 'Test text', year: 1997);

  test('Should be a subclass of YearTrivia entity', () async {
    // assert
    expect(tYearTriviaModel, isA<YearTrivia>());
  });

  group('fromJson', () {
    test('should return a valid model when JSON year is an integer', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('year_trivia.json'));
      // act
      final result = YearTriviaModel.fromJson(jsonMap);
      // assert
      expect(result, tYearTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // arrange

      // act
      final result = tYearTriviaModel.toJson();
      // assert
      final expectedResult = {
        "text": "Test text",
        "number": 1997,
      };
      expect(result, expectedResult);
    });
  });
}
