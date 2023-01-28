import 'package:hive/hive.dart';

part 'transaction.g.dart';
/// A decorator that tells Hive to store the class in the database.
@HiveType(typeId: 1)
/// A class that defines the properties of a transaction
class Transaction {
  /// Defining the properties of the class.
  @HiveField(0) /// A decorator that tells Hive to store the property in the database.
  String title;
  @HiveField(1) /// A decorator that tells Hive to store the property in the database.
  double amount;
  @HiveField(2) /// A decorator that tells Hive to store the property in the database.
  bool isExpense;

  /// A constructor.
  Transaction({
    /// A named parameter.
    required this.title,
    required this.amount,
    this.isExpense = true,
  });
}