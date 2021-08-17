import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd/features/year_trivia/presentation/bloc/year_trivia_bloc.dart';

class YearTriviaControls extends StatefulWidget {
  YearTriviaControls({Key key}) : super(key: key);

  @override
  _YearTriviaControlsState createState() => _YearTriviaControlsState();
}

class _YearTriviaControlsState extends State<YearTriviaControls> {
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
            hintText: 'Input a year',
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
    BlocProvider.of<YearTriviaBloc>(context)
        .add(GetTriviaForConcreteYear(_controller.text));
    _clear();
  }

  void _dispachRandom() {
    BlocProvider.of<YearTriviaBloc>(context).add(GetTriviaForRandomYear());
    _clear();
  }
}
