import 'package:flutter/material.dart';
import '../../models/expense.dart';

class CategoryCard extends StatelessWidget {
  final List<double> amounts;
  final List<ExpenseType> categories;

  const CategoryCard({
    super.key,
    required this.amounts,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(amounts.length, (index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${amounts[index].toStringAsFixed(0)}\$',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Icon(
                getCategoryIcon(categories[index]),
                size: 22,
                color: Colors.black,
              ),
            ],
          );
        }),
      ),
    );
  }
}
