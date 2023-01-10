import 'dart:io';
import 'package:budget_tracker/models/transaction.dart';
import 'package:budget_tracker/widgets/Cards/transaction_card.dart';
import 'package:budget_tracker/widgets/Dialogs/add_transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final format = NumberFormat.simpleCurrency(
      locale: Platform.localeName,
      name: 'NGN',
    );
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context, 
            builder: (builder) {
              return AddTransactionDialog(
                itemToAdd: (transaction) {
                  setState(() {
                    transactions.add(transaction);
                  });
                }
              );
            }
          );
        },
        child: const Icon(
          Icons.add,
        )
      ),
      body: SingleChildScrollView( // Allows the column to be scrollable
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: CircularPercentIndicator(
                    radius: screenSize.width / 2,
                    lineWidth: 10.0, // how thick the line is
                    percent: .5, // percent goes from 0 -> 1
                    backgroundColor: Colors.white,
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${format.currencySymbol}5,500",
                          style: GoogleFonts.urbanist(
                            fontSize: 35, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Balance",
                          style: GoogleFonts.urbanist(
                            fontSize: 18, 
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    progressColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  "Items",
                  style: GoogleFonts.urbanist(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ...List.generate(
                  transactions.length, 
                  (index) => TransactionCard(
                    transaction: transactions[index],
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}

