import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

var uuid = Uuid();

enum ExpenseType { FOOD, TRAVEL, LEISURE, WORK }

IconData getCategoryIcon(ExpenseType category) {
  switch (category) {
    case ExpenseType.FOOD:
      return Icons.fastfood;
    case ExpenseType.TRAVEL:
      return Icons.flight;
    case ExpenseType.WORK:
      return Icons.work;
    case ExpenseType.LEISURE:
      return Icons.movie;
  }
}

class Expense {
  String id = uuid.v4();
  String title;
  double amount;
  DateTime date;
  ExpenseType category;

  Expense(this.id, this.title, this.amount, this.date, this.category);
}
