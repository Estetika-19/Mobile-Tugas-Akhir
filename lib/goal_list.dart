import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'goal.dart'; // Mengimpor model Goal

class GoalListPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
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
                  return goals.isEmpty
                      ? const Center(
                          child: Text(
                            'No goals added yet!',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        )
                      : ListView.builder(
                          itemCount: goals.length,
                          itemBuilder: (context, index) {
                            var goal = goals[index];
                            return Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      goal.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Target: Rp ${goal.targetAmount.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),

            // Form untuk menambah goal baru
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Goal Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Target Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
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
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Please enter valid goal name and amount')));
                }
              },
              child: const Text('Add Goal'),
            ),
          ],
        ),
      ),
    );
  }
}
