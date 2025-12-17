import 'package:flutter/material.dart';
import '../expenses/expenses.dart';
import '../expenses/expense_form.dart';
import '../expenses/statistic_card.dart';
import '../../models/expense.dart';
import '../../data/expense_list.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<Expense> _expenses = List.from(expenseList);

  void _navigateToAddExpense() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseForm(onAddExpense: _addExpense),
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _expenses.remove(expense);
    });
  }

  void _showUndoSnackBar(Expense expense, int index) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _expenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'No expenses found. Start adding some!',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget _buildExpenseList() {
    return ListView.builder(
      itemCount: _expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(_expenses[index].id),
        background: _buildDismissBackground(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          final removedExpense = _expenses[index];
          final removedIndex = index;
          _removeExpense(removedExpense);
          _showUndoSnackBar(removedExpense, removedIndex);
        },
        child: ExpenseItem(_expenses[index]),
      ),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(Icons.delete, color: Colors.white, size: 40),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ronan Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddExpense,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: ExpensesStatistics(expenses: _expenses),
          ),
          Expanded(
            child: _expenses.isEmpty ? _buildEmptyState() : _buildExpenseList(),
          ),
        ],
      ),
    );
  }
}
