import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:tdd/core/usecases/usecase.dart';
import 'package:tdd/core/utils/input_converter.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';
import 'package:tdd/features/year_trivia/domain/usecases/get_concrete_year_trivia.dart';
import 'package:tdd/features/year_trivia/domain/usecases/get_random_year_trivia.dart';
import 'package:tdd/features/year_trivia/presentation/bloc/year_trivia_bloc.dart';

class MockGetConcreteYearTrivia extends Mock implements GetConcreteYearTrivia {}

class MockGetRandomYearTrivia extends Mock implements GetRandomYearTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  YearTriviaBloc bloc;
  MockGetConcreteYearTrivia mockGetConcreteYearTrivia;
  MockGetRandomYearTrivia mockGetRandomYearTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteYearTrivia = MockGetConcreteYearTrivia();
    mockGetRandomYearTrivia = MockGetRandomYearTrivia();
    mockInputConverter = MockInputConverter();
    bloc = YearTriviaBloc(
      concrete: mockGetConcreteYearTrivia,
      random: mockGetRandomYearTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be EmptyYear', () {
    // assert
    expect(bloc.state, equals(EmptyYear()));
  });

  group('getTriviaForConcreteYear', () {
    final tYearString = '1997';
    final tYearParsed = int.parse(tYearString);
    final tYearTrivia = YearTrivia(text: 'Test text', year: 1997);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tYearParsed));

    test(
        'should call the InputCoverter to validate and convert the string to an unsinged integer',
        () async {
      // arrange
      setUpMockInputConverterSuccess();
      // act
      bloc.add(GetTriviaForConcreteYear(tYearString));
      await untilCalled(
          mockInputConverter.stringToUnsignedInteger(tYearString));
      // assert
      verify(mockInputConverter.stringToUnsignedInteger(tYearString));
    });

    blocTest(
      'should emit [ErrorYear] when the input is invalid',
      build: () {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteYear(tYearString)),
      expect: () => [ErrorYear(message: INVALID_INPUT_FAILURE_MESSAGE)],
    );

    blocTest(
      'should get data from concrete usecase',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteYearTrivia(any))
            .thenAnswer((_) async => Right(tYearTrivia));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteYear(tYearString)),
      verify: (_) => {
        verify(mockGetConcreteYearTrivia(YearParams(year: tYearParsed))),
      },
    );

    blocTest(
      'should emit [LoadingYear, LoadedYear] when data is gotten succesfully',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteYearTrivia(any))
            .thenAnswer((_) async => Right(tYearTrivia));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteYear(tYearString)),
      expect: () => [LoadingYear(), LoadedYear(trivia: tYearTrivia)],
    );

    blocTest(
      'should emit [LoadingYear, ErrorYear] with Server Failure',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteYearTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteYear(tYearString)),
      expect: () => [LoadingYear(), ErrorYear(message: SERVER_FAILURE_MESSAGE)],
    );

    blocTest(
      'should emit [LoadingYear, ErrorYear] with Cache Failure',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteYearTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteYear(tYearString)),
      expect: () => [LoadingYear(), ErrorYear(message: CACHE_FAILURE_MESSAGE)],
    );
  });

  group('getTriviaForRandomYear', () {
    final tYearTrivia = YearTrivia(text: 'Test text', year: 1997);

    blocTest(
      'should emit [LoadingYear, LoadedYear] when data is gotten succesfully',
      build: () {
        when(mockGetRandomYearTrivia(any))
            .thenAnswer((_) async => Right(tYearTrivia));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForRandomYear()),
      expect: () => [LoadingYear(), LoadedYear(trivia: tYearTrivia)],
    );

    blocTest(
      'should emit [LoadingYear, ErrorYear] with Server Failure',
      build: () {
        when(mockGetRandomYearTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForRandomYear()),
      expect: () => [LoadingYear(), ErrorYear(message: SERVER_FAILURE_MESSAGE)],
    );

    blocTest(
      'should emit [LoadingYear, ErrorYear] with Cache Failure',
      build: () {
        when(mockGetRandomYearTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForRandomYear()),
      expect: () => [LoadingYear(), ErrorYear(message: CACHE_FAILURE_MESSAGE)],
    );
  });
}
