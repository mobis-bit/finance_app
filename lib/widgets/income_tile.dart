import 'package:flutter/material.dart';

class IncomeTile extends StatelessWidget {
  final String incomeDesc;
  final double incomeAmount;
  final Function editIncome;
  IncomeTile({this.incomeAmount, this.incomeDesc, this.editIncome});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: editIncome,
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              incomeDesc,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Income',
                  style: TextStyle(color: Colors.teal, fontSize: 18),
                ),
                Text(
                  incomeAmount.toString(),
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
