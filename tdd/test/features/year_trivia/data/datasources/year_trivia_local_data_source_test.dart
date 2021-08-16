import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/features/year_trivia/data/datasources/year_trivia_local_data_source.dart';
import 'package:tdd/features/year_trivia/data/models/year_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  YearTriviaLocalDataSourceImpl datasource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = YearTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastYearTrivia', () {
    final tYearTriviaModel = YearTriviaModel.fromJson(
        json.decode(fixture('year_trivia_cached.json')));

    test(
        'should return YearTrivia from SharedPreferences when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(CACHED_YEAR_TRIVIA))
          .thenReturn(fixture('year_trivia_cached.json'));
      // act
      final result = await datasource.getLastYearTrivia();
      // assert
      verify(mockSharedPreferences.getString(CACHED_YEAR_TRIVIA));
      expect(result, equals(tYearTriviaModel));
    });

    test('should throw a CacheException when there is not a cached value', () {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = datasource.getLastYearTrivia;
      // assert
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('cacheYearTrivia', () {
    final tYearTriviaModel = YearTriviaModel(text: 'Test text', year: 1997);

    test('should call SharedPreferences to cache data', () {
      // act
      datasource.cacheYearTrivia(tYearTriviaModel);
      // assert
      final expectedJson = json.encode(tYearTriviaModel.toJson());
      verify(
        mockSharedPreferences.setString(
          CACHED_YEAR_TRIVIA,
          expectedJson,
        ),
      );
    });
  });
}
