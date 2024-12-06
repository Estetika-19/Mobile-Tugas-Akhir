import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Hive untuk membaca saldo
import 'currency.dart';
import 'goal_list.dart';
import 'profil.dart';
import 'waktu.dart'; // Mengimpor model Goal

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0; // Menyimpan halaman yang aktif

  final List<Widget> _pages = [
    GoalListPage(), // Halaman Goals
    ProfileScreen(), // Halaman Profil
    ExchangeCurrencyPage(), // Halaman Exchange Mata Uang
    KonversiWaktuScreen(), // Halaman Konversi Waktu
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah halaman berdasarkan item yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    final saldoBox = Hive.box('saldoBox'); // Membuka box Hive
    double currentSaldo =
        saldoBox.get('saldo', defaultValue: 0.0); // Mendapatkan saldo

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blue, // Warna biru pada AppBar
      ),
      body: Column(
        children: [
          // Widget untuk menampilkan saldo
          Container(
            color: Colors.blue[100],
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Saldo:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  '${currentSaldo.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          // Menampilkan halaman sesuai index
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Menampilkan item aktif
        onTap: _onItemTapped, // Fungsi untuk navigasi halaman
        backgroundColor: Colors.blue, // Warna biru untuk BottomNavigationBar
        selectedItemColor: Colors.blue, // Warna untuk item yang aktif
        unselectedItemColor: Colors.blueGrey, // Warna item yang tidak aktif
        elevation: 10, // Menambahkan elevasi untuk efek bayangan
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Goals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: 'Exchange',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Time Conversion',
          ),
        ],
      ),
    );
  }
}
