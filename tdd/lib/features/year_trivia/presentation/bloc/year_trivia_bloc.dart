import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:tdd/core/usecases/usecase.dart';
import 'package:tdd/core/utils/input_converter.dart';
import 'package:tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';
import 'package:tdd/features/year_trivia/domain/usecases/get_concrete_year_trivia.dart';
import 'package:tdd/features/year_trivia/domain/usecases/get_random_year_trivia.dart';

part 'year_trivia_event.dart';
part 'year_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class YearTriviaBloc extends Bloc<YearTriviaEvent, YearTriviaState> {
  final GetConcreteYearTrivia getConcreteYearTrivia;
  final GetRandomYearTrivia getRandomYearTrivia;
  final InputConverter inputConverter;

  YearTriviaBloc({
    @required GetConcreteYearTrivia concrete,
    @required GetRandomYearTrivia random,
    @required this.inputConverter,
  })  : getConcreteYearTrivia = concrete,
        getRandomYearTrivia = random,
        super(EmptyYear());

  @override
  Stream<YearTriviaState> mapEventToState(
    YearTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteYear) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.yearString);
      yield* inputEither.fold((failure) async* {
        yield ErrorYear(message: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield LoadingYear();
        final failureOrTrivia = await getConcreteYearTrivia(
          YearParams(
            year: integer,
          ),
        );

        yield* _eitherLoadedOrErrorState(failureOrTrivia);
      });
    } else if (event is GetTriviaForRandomYear) {
      yield LoadingYear();
      final failureOrTrivia = await getRandomYearTrivia(NoParams());

      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<YearTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, YearTrivia> either,
  ) async* {
    yield either.fold(
      (failure) => ErrorYear(message: _mapFailureToMessage(failure)),
      (trivia) => LoadedYear(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
