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
      backgroundColor: Colors.white, // Latar belakang putih
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue, // Warna biru pada AppBar
        elevation: 0,
      ),
      body: Column(
        children: [
          // Widget untuk menampilkan saldo
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[50], // Latar biru muda
              borderRadius: BorderRadius.circular(12.0), // Radius melengkung
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Saldo Anda:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'Rp ${currentSaldo.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
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
        backgroundColor: Colors.white, // Warna putih untuk BottomNavigationBar
        selectedItemColor: Colors.blue, // Warna untuk item yang aktif
        unselectedItemColor: Colors.blueGrey, // Warna item yang tidak aktif
        type: BottomNavigationBarType.fixed, // Mengatur item tetap terlihat
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
