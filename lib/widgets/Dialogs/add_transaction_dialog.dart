import 'dart:io';

import 'package:budget_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddTransactionDialog extends StatefulWidget {
  final Function(Transaction) itemToAdd;

  const AddTransactionDialog({
    required this.itemToAdd,
    Key? key
  }) : super(key: key);

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  /// Creating a text editing controller for the title and amount text fields.
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  bool _isExpenseController = true;
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    /// A way to format the currency to the user's locale.
    final format = NumberFormat.simpleCurrency(
      locale: Platform.localeName,
      name: 'NGN',
    );

    return Dialog(
      child: SizedBox(
        width: (screenSize.width / 1.3),
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                "Add an expense",
                style: GoogleFonts.openSans(
                  fontSize: 16
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Name of Expense",
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter> [
                  FilteringTextInputFormatter.digitsOnly
                ],  
                decoration: InputDecoration(
                  hintText: "Amount in ${format.currencySymbol}",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Is expense?",
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  Switch.adaptive(
                    value: _isExpenseController, 
                    onChanged: (status) {
                      setState(() {
                        _isExpenseController = status;
                      });
                    }
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
                    widget.itemToAdd(
                      Transaction(
                        title: titleController.text,
                        amount: double.parse(amountController.text),
                        isExpense: _isExpenseController,
                      )
                    );
                    Navigator.pop(context);
                  }
                }, 
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 16,
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