import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tdd/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:tdd/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:tdd/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:tdd/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:tdd/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Number Trivia"),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(message: 'Start searching!');
                } else if (state is Loaded) {
                  return TriviaDisplay(trivia: state.trivia);
                } else if (state is Loading) {
                  return LoadingWidget();
                } else if (state is Error) {
                  return MessageDisplay(message: state.message);
                } else
                  return null;
              }),
              SizedBox(
                height: 20,
              ),
              TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}
