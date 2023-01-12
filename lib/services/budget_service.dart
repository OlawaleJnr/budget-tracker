import 'package:budget_tracker/models/transaction.dart';
import 'package:flutter/material.dart';

class BudgetService extends ChangeNotifier {
  double _budget = 0.0;
  double balance = 0.0;

  List<Transaction> _transactions = [];

  double get budget => _budget;

  List<Transaction> get transactions => _transactions;

  set budget(double amount) {
    _budget = amount;
    balance = amount;
    notifyListeners();
  }

  void updateBalance(Transaction transaction) {
    if (transaction.isExpense) {
      balance -= transaction.amount;
    } else {
      balance += transaction.amount;
      if (balance > _budget) {
        _budget = balance;
      } else {
        _budget = transaction.amount;
      }
    }
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    updateBalance(transaction);
    notifyListeners();
  }
}