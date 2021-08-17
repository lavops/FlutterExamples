import 'package:tdd/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd/core/usecases/usecase.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';
import 'package:tdd/features/year_trivia/domain/repositories/year_trivia_repository.dart';

class GetRandomYearTrivia extends UseCase<YearTrivia, NoParams> {
  final YearTrivaRepository repository;

  GetRandomYearTrivia(this.repository);

  @override
  Future<Either<Failure, YearTrivia>> call(NoParams params) async {
    return await repository.getRandomYearTrivia();
  }
}
