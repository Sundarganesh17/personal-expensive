import 'package:flutter/material.dart';
import './chart_bar.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class chart extends StatelessWidget {
  final List<Transaction> resentTransAction;
  chart(this.resentTransAction);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (var i = 0; i < resentTransAction.length; i++) {
        if (resentTransAction[i].date.day == weekDay.day &&
            resentTransAction[i].date.month == weekDay.month &&
            resentTransAction[i].date.year == weekDay.year) {
          totalSum += resentTransAction[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((data) {
            Flexible(
              fit: FlexFit.tight,
            );
            return chartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending);
          }).toList(),
        ),
      ),
    );
  }
}
