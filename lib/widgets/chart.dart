import 'package:am_rich/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/trasaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(
      7,
      (index) {
        final weekday = DateTime.now().subtract(Duration(days: index));

        var totalSum = 0.0;
        for (var i = 0; i < transactions.length; i++) {
          if (transactions[i].date.day == weekday.day &&
              transactions[i].date.month == weekday.month &&
              transactions[i].date.year == weekday.year) {
            totalSum += transactions[i].amount;
          }
        }
        print(totalSum);
        return {
          'day': DateFormat.E().format(weekday).substring(0, 1),
          'amount': totalSum
        };
      },
    );
  }

  double get percentageSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...(groupedTransactionsValues as List).map((transactiondata) {
              return Flexible(
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: ChartBar(
                      transactiondata['day'],
                      transactiondata['amount'],
                      percentageSpending == 0.0
                          ? 0.0
                          : (transactiondata['amount'] as double) /
                              percentageSpending),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
