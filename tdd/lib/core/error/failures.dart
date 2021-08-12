import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // final List<Object> properties;

  // Failure({required this.properties});

  // @override
  // List<Object> get props => properties;

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
