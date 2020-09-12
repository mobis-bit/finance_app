import 'package:finance_app/screens/add_category.dart';
import 'package:finance_app/screens/add_expenses.dart';
import 'package:finance_app/screens/add_income.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        if (index == 0) {
          Get.to(AddIncome());
        }
        if (index == 1) {
          Get.to(AddExpenses());
        }
        if (index == 2) {
          Get.bottomSheet(SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AddCategory(),
          )));
        }
      },
      currentIndex: 1,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.teal,
      selectedItemColor: Colors.teal,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.create_new_folder),
          title: Text(
            'Add Income',
            style: TextStyle(fontSize: 15),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.create_new_folder),
          title: Text(
            'Add Expense',
            style: TextStyle(fontSize: 15),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.create_new_folder),
          title: Text(
            'Add Category',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
