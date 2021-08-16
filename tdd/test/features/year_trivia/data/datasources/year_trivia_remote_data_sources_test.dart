import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/features/year_trivia/data/datasources/year_trivia_remote_data_source.dart';
import 'package:tdd/features/year_trivia/data/models/year_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  YearTriviaRemoteDataSourceImpl datasource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = YearTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void mockClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('year_trivia.json'), 200));
  }

  void mockClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Failure', 404));
  }

  group('getConcreteYearTrivia', () {
    final tYear = 1997;
    final tYearTriviaModel =
        YearTriviaModel.fromJson(json.decode(fixture('year_trivia.json')));

    test('should preform a GET request on URL with year being the endpoint',
        () async {
      // arrange
      mockClientSuccess200();
      // act
      datasource.getConcreteYearTrivia(tYear);
      // assert
      verify(
        mockHttpClient.get(
          Uri.parse('http://numbersapi.com/$tYear/year'),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });

    test('should return YearTrivia when response code is 200', () async {
      // arrange
      mockClientSuccess200();
      // act
      final result = await datasource.getConcreteYearTrivia(tYear);
      // assert
      expect(result, equals(tYearTriviaModel));
    });

    test('should throw a ServerException when response code is 404', () {
      // arrange
      mockClientFailure404();
      // act
      final call = datasource.getConcreteYearTrivia;
      // assert
      expect(() => call(tYear), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRandomYearTrivia', () {
    final tYearTriviaModel =
        YearTriviaModel.fromJson(json.decode(fixture('year_trivia.json')));

    test('should preform a GET request on URL with year being the endpoint',
        () async {
      // arrange
      mockClientSuccess200();
      // act
      datasource.getRandomYearTrivia();
      // assert
      verify(
        mockHttpClient.get(
          Uri.parse('http://numbersapi.com/random/year'),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });

    test('should return YearTrivia when response code is 200', () async {
      // arrange
      mockClientSuccess200();
      // act
      final result = await datasource.getRandomYearTrivia();
      // assert
      expect(result, equals(tYearTriviaModel));
    });

    test('should throw a ServerException when response code is 404', () {
      // arrange
      mockClientFailure404();
      // act
      final call = datasource.getRandomYearTrivia;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
