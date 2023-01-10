import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddBudgetDialog extends StatefulWidget {
  /// A function that takes in a double and returns nothing.
  final Function(double) budget;

  /// A constructor that takes in a function and a key.
  const AddBudgetDialog({
    required this.budget,
    Key? key
  }) : super(key: key);

  @override
  State<AddBudgetDialog> createState() => _AddBudgetDialogState();
}

class _AddBudgetDialogState extends State<AddBudgetDialog> {
  /// A way to get the value of the text field.
  final TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// Getting the size of the screen.
    final screenSize = MediaQuery.of(context).size;
    /// A way to format the currency to the user's locale.
    final format = NumberFormat.simpleCurrency(
      locale: Platform.localeName,
      name: 'NGN',
    );
    
    return Dialog(
      child: SizedBox(
        width: (screenSize.width / 1.3),
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add a budget",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter> [
                  FilteringTextInputFormatter.digitsOnly
                ],  
                decoration: InputDecoration(
                  hintText: "Budget in ${format.currencySymbol}",
                  hintStyle: GoogleFonts.openSans(
                    fontSize: 12,
                  ),
                ),
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if(budgetController.text.isNotEmpty) {
                    widget.budget(double.parse(budgetController.text));
                    Navigator.pop(context);
                  }
                }, 
                child: const Text(
                  "Add",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}