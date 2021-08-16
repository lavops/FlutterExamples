import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/usecases/usecase.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';
import 'package:tdd/features/year_trivia/domain/repositories/year_trivia_repository.dart';
import 'package:tdd/features/year_trivia/domain/usecases/get_random_year_trivia.dart';

class MockYearTriviaRepository extends Mock implements YearTrivaRepository {}

void main() {
  GetRandomYearTrivia usecase;
  MockYearTriviaRepository repository;

  setUp(() {
    repository = MockYearTriviaRepository();
    usecase = GetRandomYearTrivia(repository: repository);
  });

  final tYearTrivia = YearTrivia(text: 'text', year: 1997);

  test('should get trivia from the repository', () async {
    // arrange
    when(repository.getRandomYearTrivia())
        .thenAnswer((_) async => Right(tYearTrivia));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tYearTrivia));
    verify(repository.getRandomYearTrivia());
    verifyNoMoreInteractions(repository);
  });
}
