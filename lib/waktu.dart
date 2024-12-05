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
    // Mengambil input dari TextField
    String input = _controller.text;

    // Memeriksa format input menggunakan split
    List<String> timeParts = input.split('.');
    if (timeParts.length != 2) {
      // Jika format salah, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Format waktu harus HH.MM'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Parsing jam dan menit
    int? jam = int.tryParse(timeParts[0]);
    int? menit = int.tryParse(timeParts[1]);

    // Validasi nilai jam dan menit
    if (jam == null ||
        menit == null ||
        jam < 0 ||
        jam > 23 ||
        menit < 0 ||
        menit > 59) {
      // Jika input tidak valid, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jam harus antara 0-23 dan menit antara 0-59.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Format jam dan menit ke zona waktu lainnya
    setState(() {
      _wib =
          '${jam.toString().padLeft(2, '0')}:${menit.toString().padLeft(2, '0')} WIB';
      _wita =
          '${((jam + 1) % 24).toString().padLeft(2, '0')}:${menit.toString().padLeft(2, '0')} WITA';
      _wit =
          '${((jam + 2) % 24).toString().padLeft(2, '0')}:${menit.toString().padLeft(2, '0')} WIT';

      // Konversi ke waktu London (GMT/UTC)
      _london =
          '${((jam - 7 + 24) % 24).toString().padLeft(2, '0')}:${menit.toString().padLeft(2, '0')} London (GMT)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Konversi Waktu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Waktu (HH:MM)'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _konversiWaktu,
              child: Text('Konversi'),
            ),
            if (_wib.isNotEmpty) ...[
              Text('WIB: $_wib'),
              Text('WITA: $_wita'),
              Text('WIT: $_wit'),
              Text('London: $_london'),
            ],
          ],
        ),
      ),
    );
  }
}
