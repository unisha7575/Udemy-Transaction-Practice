import 'package:flutter/material.dart';
import 'package:udemy_transaction_praction/widgets/chart.dart';
import 'package:udemy_transaction_praction/widgets/charts_item.dart';
import 'package:udemy_transaction_praction/widgets/new_transaction.dart';
import 'package:udemy_transaction_praction/widgets/transaction_page.dart';

import 'model/transaction_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Transaction> get _recentTransaction{
    return _userTransaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    } ).toList();
  }



  void startAddNewTranction() {
    // Navigator.pop(context);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return NewTransaction(
            addNewTx: _addNewTransaction,
          );
        });
  }

  final List<Transaction> _userTransaction = [
    Transaction(
        id: 1, title: "shoes", date: DateTime(2022, 12, 18, 18), amount: "20"),
    Transaction(id: 1, title: "dress", date: DateTime.now(), amount: "18")
  ];
  var a = 1;
  bool isLandScape = true;

  void _addNewTransaction(String txTitle, String txAmount, DateTime timeDate) {
    final newTx =
        Transaction(id: a, title: txTitle, date: timeDate, amount: txAmount);

    setState(() {
      _userTransaction.add(newTx);
      a++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text("Expenses",style: TextStyle(fontSize: 20),),
              ),
              const Spacer(),
              InkWell(
                  onTap: (){},
                  child: const Icon(Icons.add))
            ],

          ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: const Icon(Icons.add),
          onPressed: () => startAddNewTranction(),
        ),
        body:OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape) {
              return Column(
                  children: const [
// Expanded(child: NewTransaction(list1:_userTransaction , addNewTx: _addNewTransaction,)),
              Center(child: Text('Screen is in landscape orientation')),

            ],);
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: 220,
                      child: ChartsItem (recentTransaction: [],)),
                  Expanded(
                   // flex: 4,
                    child: TransactionPage(
                      list: _userTransaction,
                    ),
                  ),
                ],
              );
            }
          },
        )
      ),
    );
  }
}
