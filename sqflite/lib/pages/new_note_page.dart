import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_demo/pages/home_page.dart';

class NewNotePage extends StatefulWidget {
  NewNotePage({Key? key}) : super(key: key);

  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  DateTime _date = DateTime.now();
  String _priority = 'Low';

  TextEditingController _dateController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('MMM dd. yyyy');
  final List<String> _priorities = ['Low', 'Medium', 'High'];

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1997),
      lastDate: DateTime(2100),
    );

    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Title',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: TextFormField(
                          controller: _titleController,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _title = value.toString();
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          onTap: _handleDatePicker,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Date',
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: DropdownButtonFormField(
                          value: _priority,
                          onChanged: (value) {
                            setState(() {
                              _priority = value.toString();
                            });
                          },
                          items: _priorities.map((String priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }).toList(),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          child: Text(
                            "Add Note",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
