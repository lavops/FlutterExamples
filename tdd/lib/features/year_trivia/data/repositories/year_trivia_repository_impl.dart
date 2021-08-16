import 'package:flutter/material.dart';
import 'package:tdd/core/error/exceptions.dart';
import 'package:tdd/core/platform/network_info.dart';
import 'package:tdd/features/year_trivia/data/datasources/year_trivia_local_data_source.dart';
import 'package:tdd/features/year_trivia/data/datasources/year_trivia_remote_data_source.dart';
import 'package:tdd/features/year_trivia/data/models/year_trivia_model.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd/features/year_trivia/domain/repositories/year_trivia_repository.dart';

typedef Future<YearTriviaModel> _ConcreteOrRandomChooser();

class YearTriviaRepositoryImpl extends YearTrivaRepository {
  final YearTriviaRemoteDataSource remoteDataSource;
  final YearTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  YearTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, YearTrivia>> getConcreteYearTrivia(int year) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteYearTrivia(year);
    });
  }

  @override
  Future<Either<Failure, YearTrivia>> getRandomYearTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomYearTrivia();
    });
  }

  Future<Either<Failure, YearTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheYearTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastYearTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
