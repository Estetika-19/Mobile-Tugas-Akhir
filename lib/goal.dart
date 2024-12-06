import 'package:hive/hive.dart';

part 'goal.g.dart'; // Untuk kode Hive Generator

@HiveType(typeId: 1)
class Goal {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double targetAmount;

  Goal({required this.name, required this.targetAmount});
}
