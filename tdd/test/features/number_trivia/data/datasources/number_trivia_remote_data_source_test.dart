import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl datasource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Failure', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'should preform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      datasource.getConcreteNumberTrivia(tNumber);
      // assert
      verify(
        mockHttpClient.get(
          Uri.parse('http://numbersapi.com/$tNumber'),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });

    test('shoudl return NumberTrivia when the response code is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await datasource.getConcreteNumberTrivia(tNumber);
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = datasource.getConcreteNumberTrivia;
      // assert
      expect(call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'should preform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      datasource.getRandomNumberTrivia();
      // assert
      verify(
        mockHttpClient.get(
          Uri.parse('http://numbersapi.com/random'),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });

    test('shoudl return NumberTrivia when the response code is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await datasource.getRandomNumberTrivia();
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = datasource.getRandomNumberTrivia;
      // assert
      expect(call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
