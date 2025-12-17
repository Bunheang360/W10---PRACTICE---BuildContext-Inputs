import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onAddExpense});

  final Function(Expense expense) onAddExpense;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _numberController = TextEditingController();
  ExpenseType _selectedCategory = ExpenseType.FOOD;
  DateTime? _selectedDate;

  void onCreate() {
    final title = _titleController.text;
    final amount = int.tryParse(_numberController.text) ?? 0;

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Missing Information'),
          content: const Text(
            'Please enter title, valid price, and select a date before creating the expense.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final expense = Expense(
      uuid.v4(),
      title,
      amount.toDouble(),
      _selectedDate!,
      _selectedCategory,
    );
    widget.onAddExpense(expense);
    Navigator.pop(context);
  }

  void onCancel() {
    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Expense',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(label: Text("Title")),
              maxLength: 50,
            ),

            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],

              decoration: InputDecoration(
                label: Text("Price"),
                prefix: Text('\$ '),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Category:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: DropdownButton<ExpenseType>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: ExpenseType.values.map((category) {
                      return DropdownMenuItem<ExpenseType>(
                        value: category,
                        child: Row(
                          children: [
                            Icon(getCategoryIcon(category), size: 20),
                            const SizedBox(width: 10),
                            Text(category.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? 'No date selected'
                      : DateFormat.yMd().format(_selectedDate!),
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: onCreate, child: Text("Create")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: onCancel, child: Text("Cancel")),
          ],
        ),
      ),
    );
  }
}
