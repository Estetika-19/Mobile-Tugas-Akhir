import 'package:flutter/material.dart';

class KonversiWaktuScreen extends StatefulWidget {
  @override
  _KonversiWaktuScreenState createState() => _KonversiWaktuScreenState();
}

class _KonversiWaktuScreenState extends State<KonversiWaktuScreen> {
  final _controller = TextEditingController();
  String _wib = '';
  String _wit = '';
  String _wita = '';
  String _london = '';

  void _konversiWaktu() {
    String input = _controller.text;

    List<String> timeParts = input.split('.');
    if (timeParts.length != 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Format waktu harus HH:MM'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    int? jam = int.tryParse(timeParts[0]);
    int? menit = int.tryParse(timeParts[1]);

    if (jam == null ||
        menit == null ||
        jam < 0 ||
        jam > 23 ||
        menit < 0 ||
        menit > 59) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jam harus antara 0-23 dan menit antara 0-59.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _wib =
          '${jam.toString().padLeft(2, '0')}:${menit.toString().padLeft(2, '0')} WIB';
      _wita =
          '${((jam + 1) % 24).toString().padLeft(2, '0')}:${menit.toString().padLeft(2, '0')} WITA';
      _wit =
          '${((jam + 2) % 24).toString().padLeft(2, '0')}:${menit.toString().padLeft(2, '0')} WIT';
      _london =
          '${((jam - 7 + 24) % 24).toString().padLeft(2, '0')}:${menit.toString().padLeft(2, '0')} London (GMT)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      appBar: AppBar(
        title: const Text('Konversi Waktu'),
        backgroundColor: Colors.blue, // AppBar biru
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Masukkan Waktu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Warna biru pada teks judul
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Waktu (HH.MM)',
                labelStyle: const TextStyle(color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _konversiWaktu,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Warna biru pada tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Konversi'),
            ),
            const SizedBox(height: 24),
            if (_wib.isNotEmpty)
              Card(
                elevation: 4,
                color: Colors.blue[50], // Latar belakang kartu biru pucat
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('WIB: $_wib',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.blue)),
                      const Divider(),
                      Text('WITA: $_wita',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.blue)),
                      const Divider(),
                      Text('WIT: $_wit',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.blue)),
                      const Divider(),
                      Text('London: $_london',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.blue)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
