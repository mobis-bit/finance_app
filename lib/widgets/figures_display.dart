import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FiguresCard extends StatefulWidget {
  final double netIncome, totalExpenditure, totalBudget;
  FiguresCard(
      {this.netIncome = 100,
      this.totalExpenditure = 100,
      this.totalBudget = 100});

  @override
  _FiguresCardState createState() => _FiguresCardState();
}

class _FiguresCardState extends State<FiguresCard> {
  @override
  Widget build(BuildContext context) {
    final double percentage = widget.netIncome <= 0
        ? 0
        : widget.totalExpenditure >= widget.netIncome
            ? 1
            : (widget.totalExpenditure / widget.netIncome);
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal, //Color(0XFF2C14DD),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50.0),
        ),
      ),
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '\$ ${widget.netIncome}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Net Disposable Income',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '\$ ${widget.totalExpenditure}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total Expenditure',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CircularPercentIndicator(
                backgroundWidth: 10,
                radius: 140,
                lineWidth: 20,
                backgroundColor: Colors.teal,
                progressColor: Colors.white,
                percent: percentage,
              ),
              Column(
                children: <Widget>[
                  Text(
                    '${(percentage * 100).floor()}%',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    'of income spent',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Total Budgeted',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Text(
                    '\$ ${widget.totalBudget}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Remaining to spend',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Text(
                    '\$ ${(widget.totalBudget - widget.totalExpenditure)}',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
//                    Stack(
//                      alignment: Alignment.center,
//                      children: <Widget>[
////                        LinearPercentIndicator(
////                          backgroundColor: Colors.grey,
////                          progressColor: Colors.green,
////                          percent: 0.5,
////                          lineHeight: 30,
////                          //width: MediaQuery.of(context).size.width * 1,
////                        ),
//                        Text(
//                          '45%',
//                          style: TextStyle(color: Colors.white, fontSize: 20),
//                        )
//                      ],
//                    )
        ],
      ),
    );
  }
}
