import 'package:flutter/material.dart';
import '../../models/expense.dart';
import './category_card.dart';

class ExpensesStatistics extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensesStatistics({super.key, required this.expenses});

  double getTotalFor(ExpenseType type) {
    return expenses
        .where((e) => e.category == type)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CategoryCard(
            amounts: [
              getTotalFor(ExpenseType.FOOD),
              getTotalFor(ExpenseType.TRAVEL),
              getTotalFor(ExpenseType.WORK),
              getTotalFor(ExpenseType.LEISURE),
            ],
            categories: [
              ExpenseType.FOOD,
              ExpenseType.TRAVEL,
              ExpenseType.WORK,
              ExpenseType.LEISURE,
            ],
          ),
        ),
      ],
    );
  }
}
