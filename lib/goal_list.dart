import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'goal.dart'; // Mengimpor model Goal

class GoalListPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Goals')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Daftar Goals yang sudah disimpan
            Expanded(
              child: ValueListenableBuilder<Box<Goal>>(
                valueListenable: Hive.box<Goal>('goalBox').listenable(),
                builder: (context, box, _) {
                  var goals = box.values.toList().cast<Goal>();
                  return ListView.builder(
                    itemCount: goals.length,
                    itemBuilder: (context, index) {
                      var goal = goals[index];
                      return ListTile(
                        title: Text(goal.name),
                        subtitle: Text('Target: \$${goal.targetAmount.toStringAsFixed(2)}'),
                      );
                    },
                  );
                },
              ),
            ),

            // Form untuk menambah goal baru
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Goal Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Target Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                double amount = double.tryParse(amountController.text) ?? 0.0;

                if (name.isNotEmpty && amount > 0) {
                  var newGoal = Goal(name: name, targetAmount: amount);
                  var box = Hive.box<Goal>('goalBox');
                  box.add(newGoal); // Menyimpan goal ke Hive

                  // Clear fields setelah menyimpan goal
                  nameController.clear();
                  amountController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter valid goal name and amount')));
                }
              },
              child: Text('Add Goal'),
            ),
          ],
        ),
      ),
    );
  }
}
