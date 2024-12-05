import 'package:flutter/material.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final List<Widget> _pages = [
    // Halaman utama dengan Goals
    GoalListPage(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blue, // Warna biru pada AppBar
      ),
      body: Container(
        color: Colors.white, // Latar belakang putih untuk body
        child: _pages[
            _selectedIndex], // Menampilkan halaman sesuai dengan index yang dipilih
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Menampilkan item aktif
        onTap: _onItemTapped, // Fungsi untuk navigasi halaman
        backgroundColor: Colors.blue, // Warna biru untuk BottomNavigationBar
        selectedItemColor: Colors.blue, // Warna putih untuk item yang aktif
        unselectedItemColor: Colors
            .blueGrey, // Warna putih agak pudar untuk item yang tidak aktif
        elevation:
            10, // Menambahkan elevasi untuk efek bayangan pada bottom bar
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
