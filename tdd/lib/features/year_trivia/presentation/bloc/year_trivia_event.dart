part of 'year_trivia_bloc.dart';

abstract class YearTriviaEvent extends Equatable {
  const YearTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteYear extends YearTriviaEvent {
  final String yearString;

  GetTriviaForConcreteYear(this.yearString);

  @override
  List<Object> get props => [yearString];
}

class GetTriviaForRandomYear extends YearTriviaEvent {}
