// lib/utils.dart
import 'dart:convert';
import 'package:crypto/crypto.dart';

String encryptPassword(String password) {
  var bytes = utf8.encode(password); // Mengubah password menjadi bytes
  var hash = sha256.convert(bytes); // Menggunakan SHA-256
  return hash.toString();
}
