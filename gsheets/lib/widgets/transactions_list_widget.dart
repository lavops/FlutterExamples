import 'package:flutter/material.dart';
import 'package:gsheets_example/services/gsheets_api.dart';
import 'package:gsheets_example/widgets/transaction_widget.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: GSheetsApi.currentExpenses.length,
      itemBuilder: (context, index) {
        return TransactionWidget(
          name: GSheetsApi.currentExpenses[index][0],
          amount: GSheetsApi.currentExpenses[index][1],
          expenseOrIncome: GSheetsApi.currentExpenses[index][2],
        );
      },
    );
  }
}
