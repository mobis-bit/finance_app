import 'package:flutter/foundation.dart';

class TransactionData {
  final String txnType;
  final double txnAmount;
  final String txnDescription;
  final String txnCategory;
  final String txnDate;
  final String txnTime;
  final int txnId;

  TransactionData(
      {this.txnId,
      this.txnType,
      this.txnAmount,
      this.txnDescription,
      this.txnCategory,
      this.txnDate,
      this.txnTime});

  Map<String, dynamic> toMap() {
    return {
      'Type': txnType,
      'Amount': txnAmount,
      'Category': txnCategory,
      'Description': txnDescription,
      'Date': txnDate,
      'Time': txnTime
    };
  }
}

class TxnCategory {
  final String description;
  final double budget;
  final int id;

  TxnCategory({@required this.description, @required this.budget, this.id});

  Map<String, dynamic> toMap2() {
    return {'Description': description, 'Budget': budget};
  }
}

class FiguresModel {
  double totalExpenditure;
  double totalBudget;
  double netIncome;
  String transactionCategory;

  FiguresModel(
      {this.totalExpenditure = 0, this.totalBudget = 0, this.netIncome = 0});
}
