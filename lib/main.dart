import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'goal.dart'; // Mengimpor Goal class
import 'login.dart'; // Mengimpor halaman login

void main() async {
  // Inisialisasi Hive
  await Hive.initFlutter();

  // Register Adapter untuk Goal
  Hive.registerAdapter(GoalAdapter());

  // Membuka box untuk User dan Goal
  await Hive.openBox('userBox'); // Box untuk menyimpan user login
  await Hive.openBox<Goal>('goalBox'); // Box untuk menyimpan goals

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(), // Menampilkan halaman login terlebih dahulu
    );
  }
}
