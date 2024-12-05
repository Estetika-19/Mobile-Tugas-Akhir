import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: const Column(
        children: [
          // Bagian Profil di atas
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70, // Memperbesar ukuran foto profil
                  backgroundImage: AssetImage(
                      'assets\WhatsApp Image 2024-10-30 at 10.16.13 PM.jpeg'), // Pastikan gambar ada di folder assets
                ),
                SizedBox(height: 16),
                Text(
                  'Nama: Estetika Nusantara Yutardo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('NIM: 124220060', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Tempat Lahir: Jambi', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Tanggal Lahir: 19 November 2024',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Hobi: Membaca', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          // Bagian Kesan dan Pesan di bawah
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kesan: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bener-bener ditempa di mata kuliah ini, bukan cuma skill, tapi juga emosi dan mental',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Pesan: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Semangat Terus semuanya, Terimakasih Pak Bagus :)',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
