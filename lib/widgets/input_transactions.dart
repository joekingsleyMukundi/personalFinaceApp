import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputTransactions extends StatefulWidget {
  final Function transactionHandler;

  InputTransactions(this.transactionHandler);

  @override
  _InputTransactionsState createState() => _InputTransactionsState();
}

class _InputTransactionsState extends State<InputTransactions> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void inputHandler() {
    var titleInputData = titleController.text;
    var amountInputData = double.parse(amountController.text);
    if (titleInputData.isEmpty || amountInputData <= 0 || datePicked == null) {
      return;
    }
//with  widget. prpety of flutter you can access the property of a widget  from its state class like here
    widget.transactionHandler(
        titleController.text, double.parse(amountController.text), datePicked);

    Navigator.of(context).pop();
  }

  var datePicked;

  void datePickerHandler() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then(
      (dateSelected) {
        if (dateSelected == null) {
          return;
        } else {
          setState(() {
            datePicked = dateSelected;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),

              controller: titleController,

              onSubmitted: (val) => inputHandler(),

              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),

              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (val) => inputHandler(),
              // onChanged: (val) {
              //   amountInput = val;
              // },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(datePicked == null
                        ? 'No Date Choosen'
                        : 'Date: ${DateFormat().format(datePicked)}'),
                  ),
                  FlatButton(
                      onPressed: () {
                        datePickerHandler();
                      },
                      child: FittedBox(
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                inputHandler();
                // print(titleInput);
                // print(amountInput);
              },
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
