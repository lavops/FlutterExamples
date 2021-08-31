import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gsheets_example/services/gsheets_api.dart';
import 'package:gsheets_example/widgets/button_widget.dart';
import 'package:gsheets_example/widgets/expenses_stats_widget.dart';
import 'package:gsheets_example/widgets/loading_widget.dart';
import 'package:gsheets_example/widgets/notes_list_widget.dart';
import 'package:flutter/services.dart';
import 'package:gsheets_example/widgets/plus_button_widget.dart';
import 'package:gsheets_example/widgets/transaction_widget.dart';
import 'package:gsheets_example/widgets/transactions_list_widget.dart';

class ExpensesPage extends StatefulWidget {
  ExpensesPage({Key? key}) : super(key: key);

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final TextEditingController _controllerAmount = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  bool _isIncome = false;
  final _formKey = GlobalKey<FormState>();

  void _insertTransaction() {
    GSheetsApi.insertTransaction(
      _controllerName.text,
      _controllerAmount.text,
      _isIncome,
    );

    setState(() {});
  }

  void startLoading() {
    Timer.periodic(Duration(seconds: 1), (t) {
      if (GSheetsApi.loadingExpenses == false) {
        setState(() {});

        t.cancel();
      }
    });
  }

  void _newTransaction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('N E W  T R A N S A C T I O N'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Expense'),
                        Switch(
                          value: _isIncome,
                          onChanged: (newValue) {
                            setState(() {
                              _isIncome = newValue;
                            });
                          },
                        ),
                        Text('Income'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Amount?',
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Enter an amount';
                                }
                                return null;
                              },
                              controller: _controllerAmount,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'For what?',
                            ),
                            controller: _controllerName,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                  color: Colors.grey[600],
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  color: Colors.grey[600],
                  child: Text(
                    'Insert',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _insertTransaction();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controllerAmount.dispose();
    _controllerName.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (GSheetsApi.loadingExpenses == true) {
      startLoading();
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    // Expenses Stats Widget
                    child: ExpensesStatsWidget(
                      balance: (GSheetsApi.calculateIncome() -
                              GSheetsApi.calculateExpense())
                          .toString(),
                      income: GSheetsApi.calculateIncome().toString(),
                      expense: GSheetsApi.calculateExpense().toString(),
                      function: _newTransaction,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    'T R A N S A C T I O N S',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
          Expanded(
            child: GSheetsApi.loadingExpenses == true
                ? LoadingWidget()
                : TransactionListWidget(),
          ),
          SizedBox(
            height: 10,
          ),
          PlusButtonWidget(
            child: Text(
              '+',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            function: _newTransaction,
          ),
        ],
      ),
    );
  }
}
