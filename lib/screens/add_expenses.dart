import 'package:finance_app/db_services/db_helper.dart';
import 'package:finance_app/models/txn_data.dart';
import 'package:finance_app/screens/add_category.dart';
import 'package:finance_app/services_and_utilities/konstants_variable_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddExpenses extends StatefulWidget {
  @override
  _AddExpensesState createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final kExpDescController = TextEditingController();
  final kExpAmountController = TextEditingController();
  final _expenseFormKey = GlobalKey<FormState>();
  List<Widget> textWidgets = [];

  @override
  void initState() {
    super.initState();
    transactionCategory = 'Pick a category...';
  }

  @override
  Widget build(BuildContext context) {
//    final orientation = MediaQuery.of(context).orientation;
    String formattedDate = DateFormat.yMd().format(currentDate);
    transactionDate = formattedDate;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Add Expenses'),
            FlatButton(
              child: Text(
                'SAVE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                transactionType = 'Expense';
                submitExpense();
              },
            )
          ],
        ),
      ),
      body: Form(
        key: _expenseFormKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Table(
                border: TableBorder.all(),
                columnWidths: {1: FractionColumnWidth(0.8)},
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Center(child: Text('Description')),
                      TextFormField(
//                        autofocus: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'enter Description',
                        ),
                        controller: kExpDescController,
                        validator: (value) =>
                            value.isEmpty ? 'Input Description' : null,
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(child: Text('Category')),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Get.bottomSheet(SingleChildScrollView(
                                            child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: AddCategory(),
                                        )));
//                                        Navigator.push(
//                                            context,
//                                            MaterialPageRoute(
//                                                builder: (context) =>
//                                                    AddCategory()));
                                      },
                                      child: Text(
                                        'Add Category',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                  title: Text('Pick a Category'),
                                  content: Container(
                                    height: 300.0,
                                    width: 300.0,
                                    child: FutureBuilder(
                                      future:
                                          DatabaseHelper.instance.catQueryAll(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          categoryList =
                                              snapshot.data.reversed.toList();
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              TxnCategory category =
                                                  categoryList[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    transactionCategory =
                                                        category.description;
                                                  });
                                                },
                                                child: Card(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        '${category.description}',
                                                        style: TextStyle(
                                                            fontSize: 25),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: categoryList == null
                                                ? 0
                                                : categoryList.length,
                                          );
                                        }
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                        child: TextField(
                          textAlign: TextAlign.center,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: transactionCategory == null
                                ? 'Pick a category...'
                                : transactionCategory,
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: transactionCategory == null
                                    ? null
                                    : transactionCategory ==
                                            'Pick a category...'
                                        ? null
                                        : Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(child: Text('Amount')),
                      TextFormField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp('[\\-|\\, ]'))
                        ],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          prefix: Text(
                            ' \$ ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          hintText: 'enter Amount',
                        ),
                        controller: kExpAmountController,
                        validator: (value) =>
                            value.isEmpty ? 'Input Amount' : null,
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(child: Text('Date/Time')),
                      Card(
                        child: ListTile(
                          leading: GestureDetector(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: currentDate,
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime(2021),
                                ).then((value) {
                                  value == null
                                      ? currentDate = currentDate
                                      : setState(() {
                                          currentDate = value;
                                        });
                                });
                              },
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                              )),
                          title: Center(
                            child: Text(
                              formattedDate +
                                  ',      ' +
                                  currentTime.format(context),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          trailing: GestureDetector(
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: currentTime)
                                    .then((value) {
                                  value == null
                                      ? currentTime = currentTime
                                      : setState(() {
                                          currentTime = value;
                                        });
                                });
                              },
                              child: Icon(
                                Icons.access_time,
                                color: Colors.blue,
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
//
    );
  }

  void submitExpense() async {
    if (_expenseFormKey.currentState.validate()) {
      if (transactionData == null) {
        TransactionData expenseTransaction = TransactionData(
          txnType: transactionType,
          txnAmount: double.parse(kExpAmountController.text),
          txnDescription: kExpDescController.text,
          txnDate: transactionDate,
          txnTime: currentTime.format(context),
          txnCategory: transactionCategory,
        );
        try {
          await DatabaseHelper.instance.insert(expenseTransaction).then((id) {
            kExpDescController.clear();
            kExpAmountController.clear();
            transactionType = null;
            transactionCategory = null;
            print('This have been added successfully into $id');
            Navigator.pop(context);
          });
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
