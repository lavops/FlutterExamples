import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class YearTrivia extends Equatable {
  final String text;
  final int year;

  YearTrivia({@required this.text, @required this.year});

  @override
  List<Object> get props => [text, year];
}
