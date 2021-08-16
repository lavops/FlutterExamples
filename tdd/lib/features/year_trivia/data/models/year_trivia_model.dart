import 'package:flutter/material.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';

class YearTriviaModel extends YearTrivia {
  YearTriviaModel({
    @required String text,
    @required int year,
  }) : super(
          text: text,
          year: year,
        );

  factory YearTriviaModel.fromJson(Map<String, dynamic> json) {
    return YearTriviaModel(
      text: json['text'],
      year: (json['number'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'number': year};
  }
}
