import 'package:finance_app/db_services/db_helper.dart';
import 'package:finance_app/models/txn_data.dart';
import 'package:finance_app/services_and_utilities/konstants_variable_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddIncome extends StatefulWidget {
  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final _incomeFormKey = GlobalKey<FormState>();
  final kIncomeDescController = TextEditingController();
  final kIncomeAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMd().format(currentDate);
    transactionDate = formattedDate;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Add Income'),
            FlatButton(
              child: Text(
                'SAVE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                transactionType = 'Income';
                submitIncome();
              },
            )
          ],
        ),
      ),
      body: Form(
        key: _incomeFormKey,
        child: Container(
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
                    autofocus: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'enter Description',
                    ),
                    controller: kIncomeDescController,
                    validator: (value) =>
                        value.isEmpty ? 'Input Description' : null,
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
                      BlacklistingTextInputFormatter(RegExp('[\\-|\\, ]'))
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      prefix: Text(
                        ' \$ ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      hintText: 'enter Amount',
                    ),
                    controller: kIncomeAmountController,
                    validator: (value) => value.isEmpty ? 'Input Amount' : null,
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
                                    context: context, initialTime: currentTime)
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
      ),
    );
  }

  void submitIncome() async {
    if (_incomeFormKey.currentState.validate()) {
      if (transactionData == null) {
        TransactionData incomeTransaction = TransactionData(
          txnType: transactionType,
          txnAmount: double.parse(kIncomeAmountController.text),
          txnDescription: kIncomeDescController.text,
          txnDate: transactionDate,
          txnTime: currentTime.format(context),
        );
        try {
          await DatabaseHelper.instance.insert(incomeTransaction).then((id) {
            kIncomeDescController.clear();
            kIncomeAmountController.clear();
            transactionType = null;
            transactionCategory = null;
            Navigator.pop(context);
          });
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
