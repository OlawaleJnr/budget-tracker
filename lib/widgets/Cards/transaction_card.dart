import 'dart:io';

import 'package:budget_tracker/models/transaction.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({
    required this.transaction,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
     /// A way to format the currency to the user's locale.
    final format = NumberFormat.simpleCurrency(
      locale: Platform.localeName,
      name: 'NGN',
    );
    final formatter = NumberFormat('##,###,000');
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 25),
              blurRadius: 50,
            ),
          ],
        ),
        padding: const EdgeInsets.all(15.0),
        width: screenSize.width,
        child: Row(
          children: [
            Text(
              transaction.title,
              style: GoogleFonts.openSans(
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Text(
              "${(!transaction.isExpense) ? "+ " : "- "}${format.currencySymbol}${formatter.format(transaction.amount)}",
              style: GoogleFonts.openSans(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}