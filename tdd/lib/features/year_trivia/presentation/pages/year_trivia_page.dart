import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd/core/widgets/loading_widget.dart';
import 'package:tdd/core/widgets/message_display.dart';
import 'package:tdd/features/year_trivia/presentation/bloc/year_trivia_bloc.dart';
import 'package:tdd/features/year_trivia/presentation/widgets/year_trivia_controls.dart';
import 'package:tdd/features/year_trivia/presentation/widgets/year_trivia_display.dart';
import 'package:tdd/injection_container.dart';

class YearTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Year Trivia'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<YearTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<YearTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              BlocBuilder<YearTriviaBloc, YearTriviaState>(
                  builder: (context, state) {
                if (state is EmptyYear) {
                  return MessageDisplay(message: 'Start searching!');
                } else if (state is LoadedYear) {
                  return YearTriviaDisplay(trivia: state.trivia);
                } else if (state is LoadingYear) {
                  return LoadingWidget();
                } else if (state is ErrorYear) {
                  return MessageDisplay(message: state.message);
                } else
                  return null;
              }),
              SizedBox(
                height: 20,
              ),
              YearTriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}
