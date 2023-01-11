import 'package:flutter/material.dart';

class BudgetService extends ChangeNotifier {
  double _budget = 0.0;

  double get budget => _budget;

  set budget(double amount) {
    _budget = amount;
    notifyListeners();
  }
}