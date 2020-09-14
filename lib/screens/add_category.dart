import 'package:finance_app/db_services/db_helper.dart';
import 'package:finance_app/models/txn_data.dart';
import 'package:finance_app/services_and_utilities/konstants_variable_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ),
                FlatButton(
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    submitCategory();
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            Theme(
              data: ThemeData(
                primaryColor: Colors.teal,
                primaryColorDark: Colors.red,
              ),
              child: TextFormField(
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  labelText: 'Description',
                ),
                controller: catDescController,
                validator: (value) =>
                    value.isEmpty ? 'Input Description' : null,
              ),
            ),
            SizedBox(height: 10),
            Theme(
              data: ThemeData(
                primaryColor: Colors.teal,
                primaryColorDark: Colors.red,
              ),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[\\-|\\, ]'))
                ],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  labelText: 'Budget',
                ),
                controller: catBudgetController,
                validator: (value) => value.isEmpty ? 'Input Budget' : null,
              ),
            ),
            SizedBox(
              height: 10.0,
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
