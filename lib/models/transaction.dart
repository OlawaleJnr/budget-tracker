class Transaction {
  String title;
  double amount;
  bool isExpense;

  Transaction({
    required this.title,
    required this.amount,
    this.isExpense = true,
  });
}