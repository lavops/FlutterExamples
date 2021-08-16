import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:tdd/core/platform/network_info.dart';
import 'package:tdd/features/year_trivia/data/datasources/year_trivia_local_data_source.dart';
import 'package:tdd/features/year_trivia/data/datasources/year_trivia_remote_data_source.dart';
import 'package:tdd/features/year_trivia/data/models/year_trivia_model.dart';
import 'package:tdd/features/year_trivia/data/repositories/year_trivia_repository_impl.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';

class MockRemoteDataSource extends Mock implements YearTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements YearTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  YearTriviaRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = YearTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteYearTrivia', () {
    final tYear = 1997;
    final tYearTriviaModel = YearTriviaModel(text: 'Test text', year: 1997);
    final YearTrivia tYearTrivia = tYearTriviaModel;

    test('should check if the device is online', () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getConcreteYearTrivia(tYear);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteYearTrivia(any))
            .thenAnswer((_) async => tYearTriviaModel);
        // act
        final result = await repository.getConcreteYearTrivia(tYear);
        // assert
        verify(mockRemoteDataSource.getConcreteYearTrivia(tYear));
        expect(result, equals(Right(tYearTrivia)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteYearTrivia(any))
            .thenAnswer((_) async => tYearTriviaModel);
        // act
        await repository.getConcreteYearTrivia(tYear);
        // assert
        verify(mockRemoteDataSource.getConcreteYearTrivia(tYear));
        verify(mockLocalDataSource.cacheYearTrivia(tYearTriviaModel));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteYearTrivia(any))
            .thenThrow(ServerException());
        // act
        final result = await repository.getConcreteYearTrivia(tYear);
        // assert
        verify(mockRemoteDataSource.getConcreteYearTrivia(tYear));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('should return last locally cached data when cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastYearTrivia())
            .thenAnswer((_) async => tYearTriviaModel);
        // act
        final result = await repository.getConcreteYearTrivia(tYear);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastYearTrivia());
        expect(result, equals(Right(tYearTrivia)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastYearTrivia())
            .thenThrow(CacheException());
        // act
        final result = await repository.getConcreteYearTrivia(tYear);
        // asssert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastYearTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getRandomYearTrivia', () {
    final tYearTriviaModel = YearTriviaModel(text: 'Test text', year: 1997);
    final YearTrivia tYearTrivia = tYearTriviaModel;

    test('should check if the device is online', () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getRandomYearTrivia();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getRandomYearTrivia())
            .thenAnswer((_) async => tYearTriviaModel);
        // act
        final result = await repository.getRandomYearTrivia();
        // assert
        verify(mockRemoteDataSource.getRandomYearTrivia());
        expect(result, equals(Right(tYearTrivia)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getRandomYearTrivia())
            .thenAnswer((_) async => tYearTriviaModel);
        // act
        await repository.getRandomYearTrivia();
        // assert
        verify(mockRemoteDataSource.getRandomYearTrivia());
        verify(mockLocalDataSource.cacheYearTrivia(tYearTriviaModel));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getRandomYearTrivia())
            .thenThrow(ServerException());
        // act
        final result = await repository.getRandomYearTrivia();
        // assert
        verify(mockRemoteDataSource.getRandomYearTrivia());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('should return last locally cached data when cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastYearTrivia())
            .thenAnswer((_) async => tYearTriviaModel);
        // act
        final result = await repository.getRandomYearTrivia();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastYearTrivia());
        expect(result, equals(Right(tYearTrivia)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastYearTrivia())
            .thenThrow(CacheException());
        // act
        final result = await repository.getRandomYearTrivia();
        // asssert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastYearTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
