import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final String text;
  const NoteWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.yellow[200],
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
