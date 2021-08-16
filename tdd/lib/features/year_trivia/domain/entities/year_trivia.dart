import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class YearTrivia extends Equatable {
  final String text;
  final int number;

  YearTrivia({@required this.text, @required this.number});

  @override
  List<Object> get props => [text, number];
}
