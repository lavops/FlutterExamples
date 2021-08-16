import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/features/year_trivia/data/models/year_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class YearTriviaRemoteDataSource {
  Future<YearTriviaModel> getConcreteYearTrivia(int year);
  Future<YearTriviaModel> getRandomYearTrivia();
}

class YearTriviaRemoteDataSourceImpl implements YearTriviaRemoteDataSource {
  final http.Client client;

  YearTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<YearTriviaModel> getConcreteYearTrivia(int year) {
    return _getTriviaFromUrl('http://numbersapi.com/$year/year');
  }

  @override
  Future<YearTriviaModel> getRandomYearTrivia() {
    return _getTriviaFromUrl('http://numbersapi.com/random/year');
  }

  Future<YearTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return YearTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
