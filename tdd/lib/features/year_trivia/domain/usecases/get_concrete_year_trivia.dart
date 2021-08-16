import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd/core/usecases/usecase.dart';
import 'package:tdd/features/year_trivia/domain/entities/year_trivia.dart';
import 'package:tdd/features/year_trivia/domain/repositories/year_trivia_repository.dart';

class GetConcreteYearTrivia extends UseCase<YearTrivia, YearParams> {
  YearTrivaRepository repository;

  GetConcreteYearTrivia(this.repository);

  @override
  Future<Either<Failure, YearTrivia>> call(YearParams params) async {
    return await repository.getConcreteYearTrivia(params.year);
  }
}

class YearParams extends Equatable {
  final int year;

  YearParams({@required this.year});

  @override
  List<Object> get props => [year];
}
