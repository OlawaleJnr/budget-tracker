import 'package:budget_tracker/models/transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  /// The above code is creating a constant string that will be used to access the boxes in the Hive database.
  static const String transactionBoxKey = "transactionsBox";
  static const String balanceBoxKey = "balanceBox";
  static const String budgetBoxKey = "budgetBox";

  /// Creating a singleton instance of the class.
  static final LocalStorageService _instance = LocalStorageService._internal();

  /// The function returns the instance of the class
  /// 
  /// Returns: 
  ///   The instance of the service.
  factory LocalStorageService() {
    return _instance;
  }

  /// A private constructor.
  LocalStorageService._internal();

  Future<void> initializeHive() async {
    /// Initializing the Hive database.
    await Hive.initFlutter();

    /// Registering the adapter for the Transaction class.
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TransactionAdapter());
    }

    /// Opening the boxes in the Hive database.
    await Hive.openBox<double>(budgetBoxKey);
    await Hive.openBox<Transaction>(transactionBoxKey);
    await Hive.openBox<double>(balanceBoxKey);
  }

  /// It takes a transaction object, adds it to the transaction box, and then calls the saveBalance function to update the balance
  /// 
  /// Args:
  ///   transaction (Transaction): The transaction object that we want to save.
  void saveTransaction(Transaction transaction) {
    Hive.box<Transaction>(transactionBoxKey).add(transaction);
    saveBalance(transaction);
  }

  /// It returns a list of all the transactions in the transaction box.
  /// 
  /// Returns:
  ///   A list of all the transactions in the transaction box.
  List<Transaction> getAllTransactions() {
    return Hive.box<Transaction>(transactionBoxKey).values.toList();
  }

  Future<void> saveBalance(Transaction transaction) async {
    /// Getting the box with the key `balanceBoxKey` from the Hive database.
    final balanceBox = Hive.box<double>(balanceBoxKey);
    /// Getting the value of the key `balance` from the box `balanceBox` and if it is null, it is assigning the value `0.0` to it.
    final currentBalance = balanceBox.get("balance") ?? 0.0;
    /// Getting the budget from the budgetBoxKey box in Hive.
    final currentBudget = getBudget();
    /// Checking if the transaction is an expense or not. If it is an expense, it is subtracting the amount from the current balance and if it is not an expense, it is adding the amount to the current balance.
    if (transaction.isExpense) {
      await balanceBox.put("balance", currentBudget - transaction.amount);
    } else {
      await balanceBox.put("balance", currentBalance + transaction.amount);
      if (currentBalance > currentBudget) {
        await saveBudget(currentBalance);
      }
    }
  }

  /// Get the balance from the balanceBox, and if it doesn't exist, return 0.0.
  /// 
  /// Returns:
  ///   The balance of the user.
  double getBalance() {
    return Hive.box<double>(balanceBoxKey).get("balance") ?? 0.0;
  }

  /// Save the budget to the budgetBoxKey box in Hive.
  /// 
  /// Args:
  ///   budget (double): The budget to be saved.
  /// 
  /// Returns:
  ///   A Future<void>
  Future<void> saveBudget(double budget) {
    return Hive.box<double>(budgetBoxKey).put("budget", budget);
  }

  /// If the budgetBoxKey box exists, return the value of the budget key, otherwise return 0.0
  /// 
  /// Returns:
  ///   The budget value from the budgetBoxKey box.
  double getBudget() {
    return Hive.box<double>(budgetBoxKey).get("budget") ?? 0.0;
  }
}