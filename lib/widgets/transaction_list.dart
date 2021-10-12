import 'package:am_rich/models/trasaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function deleteTrans;
  TransactionList(this.transactions, this.deleteTrans);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Text('no transactions available'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple,
                      radius: 30,
                      child: FittedBox(
                        child: Text(
                          'Ksh${transactions[index].amount.toStringAsFixed(0)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Text(
                      DateFormat().format(transactions[index].date),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deleteTrans(transactions[index].id);
                      },
                    ),
                  ),
                ),
              );
              // Card(
              //   child: Row(
              //     children: [
              //       Container(
              //         margin:
              //             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //         decoration: BoxDecoration(
              //           border: Border.all(color: Colors.purple, width: 2),
              //         ),
              //         padding: EdgeInsets.all(10),
              //         child: Text(
              //           'Ksh: ${transactions[index].amount.toStringAsFixed(2)}',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20,
              //               color: Colors.green[300]),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             transactions[index].title,
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold, fontSize: 15),
              //           ),
              //           Text(
              //             DateFormat().format(transactions[index].date),
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 10,
              //                 color: Colors.grey),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // );
            },
            itemCount: transactions.length,
          );
  }
}
