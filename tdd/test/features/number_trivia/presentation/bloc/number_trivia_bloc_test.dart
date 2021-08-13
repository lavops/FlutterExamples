import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd/core/utils/input_converter.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = int.parse(tNumberString);
    final tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    test(
        'should call the InputCoverter to validate and convert the string to an unsinged integer',
        () async {
      // arrange
      when(() => mockInputConverter.stringToUnsignedInteger(tNumberString))
          .thenReturn(Right(tNumberParsed));
      // act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      // await untilCalled(mockInputConverter.stringToUnsignedInteger(tNumberString));
      // assert
      verify(() => mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async {
      // arrange
      when(() => mockInputConverter.stringToUnsignedInteger(tNumberString))
          .thenReturn(Left(InvalidInputFailure()));
      // assert later
      final expected = [
        Empty(),
        Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });
  });
}
