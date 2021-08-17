part of 'year_trivia_bloc.dart';

abstract class YearTriviaState extends Equatable {
  const YearTriviaState();

  @override
  List<Object> get props => [];
}

class YearTriviaInitial extends YearTriviaState {}

class EmptyYear extends YearTriviaState {}

class LoadingYear extends YearTriviaState {}

class LoadedYear extends YearTriviaState {
  final YearTrivia trivia;

  LoadedYear({@required this.trivia});

  @override
  List<Object> get props => [trivia];
}

class ErrorYear extends YearTriviaState {
  final String message;

  ErrorYear({@required this.message});

  @override
  List<Object> get props => [message];
}
