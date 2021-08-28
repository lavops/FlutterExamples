import 'package:flutter/material.dart';
import 'package:gsheets_example/gsheets_api.dart';

import 'note_widget.dart';

class NotesListWidget extends StatelessWidget {
  const NotesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: GSheetsApi.currentNotes.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return NoteWidget(text: GSheetsApi.currentNotes[index]);
      },
    );
  }
}
