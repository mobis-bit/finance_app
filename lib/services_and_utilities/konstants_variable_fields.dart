import 'package:finance_app/models/txn_data.dart';
import 'package:flutter/material.dart';

String transactionType;
String transactionCategory;
String transactionDate;
DateTime currentDate = DateTime.now();
TimeOfDay currentTime = TimeOfDay.now();
final catDescController = TextEditingController();

final catBudgetController = TextEditingController();

int selectedButton = 1;

TransactionData transactionData;
List<TxnCategory> categoryList;
