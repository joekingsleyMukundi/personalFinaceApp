import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalDaily;
  final double percentage;
  ChartBar(this.label, this.totalDaily, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text('\$${totalDaily.toStringAsFixed(0)}')),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 50,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(label)
      ],
    );
  }
}
