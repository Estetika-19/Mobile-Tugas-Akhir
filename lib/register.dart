import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ta2/utils.dart'; // Pastikan utils.dart berisi fungsi encryptPassword

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text;
                String password = passwordController.text;

                if (username.isNotEmpty && password.isNotEmpty) {
                  Box userBox = Hive.box('userBox');
                  // Cek apakah username sudah ada di dalam Hive
                  if (!userBox.containsKey(username)) {
                    // Simpan username dan password terenkripsi
                    userBox.put(username, encryptPassword(password));
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registration Successful')));
                    // Navigasi kembali ke halaman login setelah pendaftaran
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Username already taken')));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all fields')));
                }
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman login
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
