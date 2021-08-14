import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  TriviaControls({Key key}) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            _controller.text = value;
          },
          onSubmitted: (_) {
            _dispachConcrete();
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: RaisedButton(
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.accent,
                onPressed: _dispachConcrete,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: RaisedButton(
                child: Text(
                  'Get random trivia',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.accent,
                onPressed: _dispachRandom,
              ),
            ),
          ],
        )
      ],
    );
  }

  void _clear() {
    _controller.clear();
  }

  void _dispachConcrete() {
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(_controller.text));
    _clear();
  }

  void _dispachRandom() {
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
    _clear();
  }
}
