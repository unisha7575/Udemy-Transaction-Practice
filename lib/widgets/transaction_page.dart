import 'package:flutter/material.dart';
import 'package:udemy_transaction_praction/widgets/new_transaction.dart';

import '../model/transaction_detail.dart';
import 'new_transaction.dart';

class TransactionPage extends StatefulWidget {

 // final Function modalSheet;
  final List<Transaction> list;

  const TransactionPage({
    Key? key,
    required this.list,

  }) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child:widget.list.isEmpty?Text('No transaction added yet',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),): ListView(
        shrinkWrap: true,
          children: List.generate(
            widget.list.length,
                (index) {
              return Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 30,
                              child: Text(widget.list[index].amount.toString())),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.list[index].id.toString()),
                          ),

                          const SizedBox(
                            width: 5,
                          ),

                          Expanded(
                            child: Column(

                              children: [
                                ListTile(
                                  title:Text(widget.list[index].title),
                                  subtitle: Text(widget.list[index].date.toString().split(" ").first),
                                  trailing: InkWell(
                                      onTap: (){
                                        setState(() {
                                          widget.list.removeAt(index);

                                        });
                                      },
                                      child: Icon(Icons.delete,color: Colors.red,)),

                                )

                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}


