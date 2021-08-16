import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';
import 'package:tdd/features/year_trivia/domain/repositories/year_trivia_repository.dart';
import 'package:tdd/features/year_trivia/domain/usecases/get_concrete_year_trivia.dart';

class MockYearTriviaRepository extends Mock implements YearTrivaRepository {}

void main() {
  GetConcreteYearTrivia usecase;
  MockYearTriviaRepository repository;

  setUp(() {
    repository = MockYearTriviaRepository();
    usecase = GetConcreteYearTrivia(repository);
  });

  final tYear = 1997;
  final tYearTrivia = YearTrivia(text: 'text', number: 1997);

  test('Should get trivia for the year from repository', () async {
    // arrange
    when(repository.getConcreteYearTrivia(any))
        .thenAnswer((_) async => Right(tYearTrivia));
    // act
    final result = await usecase(YearParams(year: tYear));
    // assert
    expect(result, Right(tYearTrivia));
    verify(repository.getConcreteYearTrivia(tYear));
    verifyNoMoreInteractions(repository);
  });
}
