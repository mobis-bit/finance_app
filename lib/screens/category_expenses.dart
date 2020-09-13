import 'package:finance_app/db_services/db_helper.dart';
import 'package:finance_app/models/txn_data.dart';
import 'package:flutter/material.dart';

class CategoryExpenses extends StatelessWidget {
  final String category;
  CategoryExpenses({this.category});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses on $category'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
            future: DatabaseHelper.instance.queryExpensesByCategory(category),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List expenseList = snapshot.data;
                return ListView.builder(
                    itemCount: expenseList.length,
                    itemBuilder: (context, index) {
                      TransactionData expense = snapshot.data[index];
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expense.txnDescription,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  expense.txnAmount.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  '${expense.txnDate}  ${expense.txnTime}',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    });
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
