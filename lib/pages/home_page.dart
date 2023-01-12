import 'dart:io';
import 'package:budget_tracker/services/budget_service.dart';
import 'package:budget_tracker/widgets/Cards/transaction_card.dart';
import 'package:budget_tracker/widgets/Dialogs/add_transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                  final budgetService = Provider.of<BudgetService>(context, listen:false);
                  budgetService.addTransaction(transaction);
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
                  child: Consumer<BudgetService>(
                    builder: ((context, value, child) {
                      return CircularPercentIndicator(
                        radius: screenSize.width / 2,
                        lineWidth: 10.0, // how thick the line is
                        percent: (value.balance / value.budget), // percent goes from 0 -> 1
                        backgroundColor: Colors.white,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${format.currencySymbol}${value.balance.toString().split(".")[0]}",
                              style: GoogleFonts.urbanist(
                                fontSize: 30, 
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Balance",
                              style: GoogleFonts.urbanist(
                                fontSize: 16, 
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              height: 8 
                            ),
                            Text(
                              "Budget: ${format.currencySymbol}${value.budget.toString()}",
                              style: GoogleFonts.openSans(
                                fontSize: 11, 
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        progressColor: Theme.of(context).colorScheme.primary,
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  "Items",
                  style: GoogleFonts.openSans(
                    fontSize: 18, 
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<BudgetService>(
                  builder: ((context, value, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.transactions.length,
                      itemBuilder: (context, index) {
                        return TransactionCard(
                          transaction: value.transactions[index],
                        );
                      },
                    );
                  }),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}

