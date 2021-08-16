import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/features/year_trivia/data/models/year_trivia_model.dart';

abstract class YearTriviaLocalDataSource {
  Future<YearTriviaModel> getLastYearTrivia();

  Future<void> cacheYearTrivia(YearTriviaModel triviaToCache);
}

const CACHED_YEAR_TRIVIA = 'CACHED_YEAR_TRIVIA';

class YearTriviaLocalDataSourceImpl implements YearTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  YearTriviaLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<YearTriviaModel> getLastYearTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_YEAR_TRIVIA);
    if (jsonString != null) {
      return Future.value(YearTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheYearTrivia(YearTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      CACHED_YEAR_TRIVIA,
      json.encode(triviaToCache.toJson()),
    );
  }
}
