import 'dart:io'; 
import 'package:budget_tracker/view_models/budget_view_model.dart';
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
    final formatter = NumberFormat('##,###,000');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context, 
            builder: (builder) {
              return AddTransactionDialog(
                itemToAdd: (transaction) {
                  final budgetService = Provider.of<BudgetViewModel>(context, listen:false);
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
                  child: Consumer<BudgetViewModel>(
                    builder: ((context, value, child) {
                      final balance = value.getBalance();
                      final budget = value.getBudget();
                      double percentage = balance / budget;
                      if (percentage < 0) {
                        percentage = 0;
                      }
                      if (percentage > 1) {
                        percentage = 1;
                      }

                      return CircularPercentIndicator(
                        radius: screenSize.width / 2,
                        lineWidth: 10.0, // how thick the line is
                        percent: percentage, // percent goes from 0 -> 1
                        backgroundColor: Colors.white,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${format.currencySymbol}${formatter.format(balance).toString().split(".")[0]}",
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
                              "Budget: ${format.currencySymbol}${formatter.format(budget).toString()}",
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
                Consumer<BudgetViewModel>(
                  builder: ((context, value, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.transactions.length,
                      physics: const ClampingScrollPhysics(),
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

