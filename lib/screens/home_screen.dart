import 'package:finance_app/db_services/db_helper.dart';
import 'package:finance_app/models/txn_data.dart';
import 'package:finance_app/screens/app_drawer.dart';
import 'package:finance_app/screens/category_expenses.dart';
import 'package:finance_app/screens/update_income_txn.dart';
import 'package:finance_app/services_and_utilities/konstants_variable_fields.dart';
import 'package:finance_app/widgets/bottom_navigation_bar.dart';
import 'package:finance_app/widgets/expense_tile.dart';
import 'package:finance_app/widgets/figures_display.dart';
import 'package:finance_app/widgets/income_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

double income = 0.0;
double budget = 0.0;
double expenses = 0.0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<TxnCategory> categoryList;
    List<TransactionData> expTransactionList, incomeTransactionList;
    double budgetSpent;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, //Color(0XFF2b13dc),
        title: Text(
          'Personal Finance',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigator(),
      body: ListView(
        children: [
          StreamBuilder(
              stream: _fetchTransactionData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<TransactionData> transactionData = snapshot.data;
                  expenses = 0;
                  income = 0;
                  for (int i = 0;
                      i <=
                          (transactionData.length == null
                              ? 0
                              : transactionData.length - 1);
                      i++) {
                    if (transactionData[i].txnType == 'Expense') {
                      expenses += transactionData[i].txnAmount;
                    } else {
                      income += transactionData[i].txnAmount;
                    }
                  }
                  return StreamBuilder<List<TxnCategory>>(
                      stream: _fetchCategoryData(),
                      builder: (context, snapshot) {
                        List<TxnCategory> category = snapshot.data;
                        if (snapshot.hasData) {
                          budget = 0;
                          for (int a = 0;
                              a <=
                                  (category.length == null
                                      ? 0
                                      : category.length - 1);
                              a++) {
                            budget += category[a].budget;
                          }

                          return FiguresCard(
                              netIncome: income,
                              totalExpenditure: expenses,
                              totalBudget: budget);
                        }
                        return Center(
                            child: Container(
                          child: Text('loading'),
                        ));
                      });
                }
                return Center(child: Container(child: Text('loading')));
              }),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        color: selectedButton == 0
                            ? Colors.teal
                            : Colors.transparent,
//                          color: Colors.red,
                        child: Text(
                          'INCOME',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          transactionType = 'Income';
                          setState(() {
                            selectedButton = 0;
                          });
                        },
                      ),
                      FlatButton(
                        color: selectedButton == 1
                            ? Colors.teal
                            : Colors.transparent,
                        child: Text(
                          'EXPENSES',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          transactionType = 'Expense';
                          setState(() {
                            selectedButton = 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  child: Card(
                    //elevation: 20,
                    child: selectedButton == 0
                        ? StreamBuilder<List<TransactionData>>(
                            stream: _fetchIncomeData(),
                            builder: (context, snapshot) {
                              incomeTransactionList = snapshot.data;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return IncomeTile(
                                    incomeDesc: incomeTransactionList[index]
                                        .txnDescription,
                                    incomeAmount:
                                        incomeTransactionList[index].txnAmount,
                                    editIncome: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return UpdateIncome();
                                      }));
                                    },
                                  );
                                },
                                itemCount: incomeTransactionList == null
                                    ? 0
                                    : incomeTransactionList.length,
                              );
                            })
                        : StreamBuilder(
                            stream: _fetchCategoryData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                categoryList = snapshot.data;
                                return StreamBuilder(
                                  stream: _fetchExpenseData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      expTransactionList = snapshot.data;
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          budgetSpent = 0.0;
                                          for (int i = 0;
                                              i <=
                                                  expTransactionList.length - 1;
                                              i++) {
                                            if (categoryList[index]
                                                    .description
                                                    .toLowerCase() ==
                                                expTransactionList[i]
                                                    .txnCategory
                                                    .toLowerCase()) {
                                              budgetSpent +=
                                                  expTransactionList[i]
                                                      .txnAmount;
                                            }
                                          }
                                          return ExpensesTile(
                                            category:
                                                categoryList[index].description,
                                            budgetPlanned:
                                                categoryList[index].budget,
                                            budgetSpent: budgetSpent,
                                            viewCategoryExpenses: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return CategoryExpenses(
                                                  category: categoryList[index]
                                                      .description,
                                                );
                                              }));
                                            },
                                          );
                                        },
                                        itemCount: categoryList.length == null
                                            ? 0
                                            : categoryList.length,
                                      );
                                    }
                                    return Container(
                                      child: Center(
                                          child: Text('waiting for data...')),
                                    );
                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 10,
          )
        ],
      ),
    );
  }
}

Stream<List<TransactionData>> _fetchIncomeData() async* {
  while (true) {
    await Future.delayed(Duration(microseconds: 1));
    yield await DatabaseHelper.instance.queryForExpenses('Income');
  }
}

Stream<List<TxnCategory>> _fetchCategoryData() async* {
  while (true) {
    await Future.delayed(Duration(microseconds: 1));
    yield await DatabaseHelper.instance.catQueryAll();
  }
}

Stream<List<TransactionData>> _fetchExpenseData() async* {
  while (true) {
    await Future.delayed(Duration(microseconds: 1));
    yield await DatabaseHelper.instance.queryForExpenses('Expense');
  }
}

Stream<List<TransactionData>> _fetchTransactionData() async* {
  while (true) {
    await Future.delayed(Duration(microseconds: 1));
    yield await DatabaseHelper.instance.queryAll();
  }
}
