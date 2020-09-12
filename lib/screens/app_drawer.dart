import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('September 1 - 31 '),
            decoration: BoxDecoration(color: Colors.teal),
            margin: EdgeInsets.only(top: 5.0),
          ),
          Container(
            color: Colors.teal,
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Transaction History',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(
                    Icons.insert_chart,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Navigator.pop(context);
//Navigator.push(
//context,
//MaterialPageRoute(
//builder: (context) => Login(),
//),
//);
