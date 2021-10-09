import 'dart:ui';

import 'package:am_rich/widgets/chart.dart';

import './widgets/input_transactions.dart';
import './models/trasaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
//saving user input v1
  // var titleInput;
  // var amountInput;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'shirt', amount: 70.00, date: DateTime.now()),
    Transaction(id: 't1', title: 'shirt1', amount: 75.09, date: DateTime.now()),
    Transaction(id: 't1', title: 'shirt2', amount: 70.78, date: DateTime.now()),
    Transaction(id: 't1', title: 'shirt3', amount: 70.56, date: DateTime.now())
  ];

  List<Transaction> get recentTransaction {
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount) {
    var newTransaction = Transaction(
        id: DateTime.now(), title: title, amount: amount, date: DateTime.now());

    setState(
      () {
        transactions.add(newTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void startAddNewTransaction(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return InputTransactions(_addTransaction);
        },
      );
    }

    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primaryColor: Colors.amber,
          accentColor: Colors.purple,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light()
                  .textTheme
                  .copyWith(title: TextStyle(fontFamily: 'OpenSans')))),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses'),
          actions: [
            Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      startAddNewTransaction(context);
                    },
                    icon: Icon(Icons.add))),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Container(
                  width: double.infinity, child: Chart(recentTransaction)),
              TransactionList(transactions),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            },
          ),
        ),
      ),
    );
  }
}
