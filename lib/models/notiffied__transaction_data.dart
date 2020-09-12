import 'package:finance_app/db_services/db_helper.dart';
import 'package:finance_app/models/txn_data.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class FiguresData extends GetxController {
  final figuresModel = FiguresModel().obs;

  void updateIncome(double income) {
    figuresModel.update((value) {
      value.netIncome = income;
    });
  }

  void updateExpenses(double expenses) {
    figuresModel.update((value) {
      value.totalExpenditure = expenses;
    });
  }

  void updateBudget(double budget) {
    figuresModel.update((value) {
      value.totalBudget = budget;
    });
  }

  Widget updateTransactionCategory(String category) {
    return FutureBuilder(
      future: DatabaseHelper.instance.queryAll(),
      builder: (context, snapshot) {
        return ListView.builder(itemBuilder: (context, index) {
          return Text('');
        });
      },
    );
  }
}
