import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_transaction_praction/model/transaction_detail.dart';

class ChartsItem extends StatefulWidget {
  final List<Transaction> recentTransaction;

  const ChartsItem({Key? key, required this.recentTransaction})
      : super(key: key);

  @override
  State<ChartsItem> createState() => _ChartsItemState();
}

class _ChartsItemState extends State<ChartsItem> {

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for(var i = 0 ; i<widget.recentTransaction.length; i++ ) {
        if (widget.recentTransaction[i].date.day == weekDay.day &&
          widget.recentTransaction[i].date.month == weekDay.month &&
            widget. recentTransaction[i].date.year == weekDay.year) {
        totalSum += int.parse(widget.recentTransaction[index].amount);

        }
      }
      print( DateFormat.E().format(weekDay));
      print("line 34 ${totalSum}");

      return {
        'day': DateFormat.E().format(weekDay).substring(0,1),

        'amount':totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
          children: groupedTransactionValues.map((data) {
        return Text("${data['day']}:${data['amount']}");

      }).toList()),
    );
  }
}
