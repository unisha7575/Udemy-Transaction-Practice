import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_transaction_praction/widgets/transaction_page.dart';

import '../model/transaction_detail.dart';

class NewTransaction extends StatefulWidget {
  final list1;
  final Function addNewTx;

  const NewTransaction({super.key, required this.addNewTx, this.list1});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime? selectedDate;

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2050))
        .then((pickedDate) {
      selectedDate != null
          ? DateFormat.yMd().format(selectedDate!)
          : const Text("null");
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  TextEditingController titleController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Amount",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                        selectedDate != null
                            ? selectedDate.toString().split(" ").first
                            : "No Date Chosen!",
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600)),
                    const Spacer(),
                    InkWell(
                        onTap: () => presentDatePicker(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "choose Date",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.purple,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 40,
                    width: 180,
                    child: ElevatedButton(
                        onPressed: () {
                          widget.addNewTx(titleController.text,
                              amountController.text, selectedDate);
                        },
                        child: const Text("Add Tranction",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600))),
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
