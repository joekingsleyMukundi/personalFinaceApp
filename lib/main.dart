import 'dart:ui';

import 'package:am_rich/widgets/chart.dart';
import 'package:flutter/services.dart';

import './widgets/input_transactions.dart';
import './models/trasaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
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

  void _addTransaction(String title, double amount, DateTime choosenDate) {
    var newTransaction = Transaction(
        id: DateTime.now(), title: title, amount: amount, date: choosenDate);

    setState(
      () {
        transactions.add(newTransaction);
      },
    );
  }

  void deleteTransaction(Id) {
    setState(
      () {
        transactions.removeWhere(
          (element) {
            return element.id == Id;
          },
        );
      },
    );
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10),
              child: InputTransactions(_addTransaction)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  startAddNewTransaction(context);
                },
                icon: Icon(Icons.add))),
      ],
    );
    var bodyStructrure = SafeArea(
      child: Builder(
        builder: (context) => Container(
          height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
              1,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Builder(
                builder: (context) => Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(recentTransaction),
                ),
              ),
              Builder(
                builder: (context) => Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.6,
                  child: TransactionList(transactions, deleteTransaction),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Colors.amber,
        accentColor: Colors.purple,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(fontFamily: 'OpenSans'),
              button: TextStyle(color: Colors.white)),
        ),
      ),
      home: Scaffold(
        appBar: appBar,
        body: bodyStructrure,
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
