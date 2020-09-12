import 'package:finance_app/screens/add_category.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ExpensesTile extends StatelessWidget {
  final String category;
  final double budgetSpent, budgetPlanned;
  final Function viewCategoryExpenses;

  ExpensesTile(
      {this.category,
      this.budgetSpent,
      this.budgetPlanned,
      this.viewCategoryExpenses});

  @override
  Widget build(BuildContext context) {
    double percentageSpent = budgetSpent <= 0
        ? 0
        : budgetSpent >= budgetPlanned ? 1 : (budgetSpent / budgetPlanned);
    return GestureDetector(
      onTap: viewCategoryExpenses,
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              category,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Budget Spent'),
                    Text(budgetSpent.toString()) //budgetSpent.toString())
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Budget Planned'),
                    Text(budgetPlanned.toString())
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Remaining'),
                    Text((budgetPlanned - budgetSpent).toString())
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.teal,
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                                child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: AddCategory(),
                            )));
                  },
                )
              ],
            ),
            LinearPercentIndicator(
              lineHeight: 10.0,
              percent: percentageSpent,
              backgroundColor: Colors.grey,
              progressColor: percentageSpent > 0.5 ? Colors.red : Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
