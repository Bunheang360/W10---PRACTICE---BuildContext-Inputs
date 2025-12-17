import '../models/expense.dart';

List<Expense> expenseList = [
  Expense(
    uuid.v4(),
    'Flutter Course',
    19.99,
    DateTime(2024, 11, 24),
    ExpenseType.WORK,
  ),
  Expense(
    uuid.v4(),
    'Cinema',
    15.69,
    DateTime(2024, 11, 24),
    ExpenseType.LEISURE,
  ),
  Expense(
    uuid.v4(),
    'Groceries',
    45.30,
    DateTime(2024, 11, 25),
    ExpenseType.FOOD,
  ),
  Expense(
    uuid.v4(),
    'Flight to Paris',
    299.99,
    DateTime(2024, 11, 20),
    ExpenseType.TRAVEL,
  ),
];
