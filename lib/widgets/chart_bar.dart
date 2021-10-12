import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalDaily;
  final double percentage;
  ChartBar(this.label, this.totalDaily, this.percentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(
                  '\$${totalDaily.toStringAsFixed(0)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.1,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
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
              height: constraints.maxHeight * 0.1,
            ),
            Container(height: constraints.maxHeight * 0.1, child: Text(label))
          ],
        );
      },
    );
  }
}
