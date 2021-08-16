import 'package:dartz/dartz.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';

abstract class YearTrivaRepository {
  Future<Either<Failure, YearTrivia>> getConcreteYearTrivia(int year);
  Future<Either<Failure, YearTrivia>> getRandomYearTrivia();
}
