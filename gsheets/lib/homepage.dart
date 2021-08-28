import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gsheets_example/button_widget.dart';
import 'package:gsheets_example/gsheets_api.dart';
import 'package:gsheets_example/loading_widget.dart';
import 'package:gsheets_example/notes_list_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  void _save() async {
    await GSheetsApi.insert(_controller.text);

    setState(() {
      _controller.clear();
    });
  }

  void startLoading() {
    Timer.periodic(Duration(seconds: 1), (t) {
      if (GSheetsApi.loading == false) {
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
    if (GSheetsApi.loading == true) {
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
            child: GSheetsApi.loading ? LoadingWidget() : NotesListWidget(),
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
