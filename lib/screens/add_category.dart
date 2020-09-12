import 'package:finance_app/db_services/db_helper.dart';
import 'package:finance_app/models/txn_data.dart';
import 'package:finance_app/services_and_utilities/konstants_variable_fields.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _catFormKey = GlobalKey<FormState>();

  final TxnCategory category = null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _catFormKey,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add Category',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                FlatButton(
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    submitCategory();
                  },
                )
              ],
            ),
            TextFormField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              controller: catDescController,
              validator: (value) => value.isEmpty ? 'Input Description' : null,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(labelText: 'Budget'),
              controller: catBudgetController,
              validator: (value) => value.isEmpty ? 'Input Budget' : null,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitCategory() async {
    if (_catFormKey.currentState.validate()) {
      setState(() {
        transactionCategory = catDescController.text;
      });
      if (category == null) {
        TxnCategory txnCategory = TxnCategory(
            description: catDescController.text,
            budget: double.parse(catBudgetController.text));
        try {
          await DatabaseHelper.instance.catInsert(txnCategory).then((id) {
            catDescController.clear();
            catBudgetController.clear();
            Navigator.pop(context);
          });
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
