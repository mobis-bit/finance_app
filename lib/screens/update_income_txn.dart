import 'package:flutter/material.dart';

class UpdateIncome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('Edit Income'), Text('SAVE')],
      )),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Text('This is the income you want to edit')),
    );
  }
}
