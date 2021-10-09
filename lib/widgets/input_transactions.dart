import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    if (titleInputData.isEmpty || amountInputData <= 0) {
      return;
    }
//with  widget. prpety of flutter you can access the property of a widget  from its state class like here
    widget.transactionHandler(
        titleController.text, double.parse(amountController.text));

    Navigator.of(context).pop();
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
            FlatButton(
              onPressed: () {
                inputHandler();
                // print(titleInput);
                // print(amountInput);
              },
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purple),
              ),
            )
          ],
        ),
      ),
    );
  }
}
