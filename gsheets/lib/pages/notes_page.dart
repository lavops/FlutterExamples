import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gsheets_example/services/gsheets_api.dart';
import 'package:gsheets_example/widgets/button_widget.dart';
import 'package:gsheets_example/widgets/loading_widget.dart';
import 'package:gsheets_example/widgets/notes_list_widget.dart';
import 'package:flutter/services.dart';

class NotesPage extends StatefulWidget {
  NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _controller = TextEditingController();

  void _save() async {
    await GSheetsApi.insertNote(_controller.text);

    setState(() {
      _controller.clear();
    });

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void startLoading() {
    Timer.periodic(Duration(seconds: 1), (t) {
      if (GSheetsApi.loadingNotes == false) {
        setState(() {});

        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    if (GSheetsApi.loadingNotes == true) {
      startLoading();
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'P O S T  a  N O T E',
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            child:
                GSheetsApi.loadingNotes ? LoadingWidget() : NotesListWidget(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Take a note',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _controller.clear();
                        });
                      },
                    ),
                  ),
                ),
              ),
              ButtonWidget(
                text: 'P O S T',
                function: _save,
              )
            ],
          ),
        ),
      ],
    );
  }
}
