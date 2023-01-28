import 'package:budget_tracker/models/transaction.dart';
import 'package:budget_tracker/services/local_storage_service.dart';
import 'package:flutter/material.dart';

class BudgetViewModel extends ChangeNotifier {
  /// This function returns the budget from the local storage
  /// 
  /// Returns:
  ///   The budget that is stored in the local storage.
  double getBudget() {
    return LocalStorageService().getBudget();
  }

  /// This function returns the balance stored in the local storage
  /// 
  /// Returns:
  ///   The balance of the user.
  double getBalance() {
    return LocalStorageService().getBalance();
  }

  /// This is a getter function that returns the list of transactions from the local storage.
  List<Transaction> get transactions => LocalStorageService().getAllTransactions();

  /// This is a setter function that saves the budget to the local storage and notifies the listeners.
  set budget(double value) {
    LocalStorageService().saveBudget(value);
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    LocalStorageService().saveTransaction(transaction);
    notifyListeners();
  }
}