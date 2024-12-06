import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class ExchangeCurrencyPage extends StatefulWidget {
  const ExchangeCurrencyPage({Key? key}) : super(key: key);

  @override
  _ExchangeCurrencyPageState createState() => _ExchangeCurrencyPageState();
}

class _ExchangeCurrencyPageState extends State<ExchangeCurrencyPage> {
  Map<String, dynamic>? exchangeRates;
  bool isLoading = true;
  String selectedCurrency = "USD"; // Default target currency
  double convertedSaldo = 0.0;
  double enteredAmount = 100.0; // Amount entered by user

  final String apiUrl =
      "https://v6.exchangerate-api.com/v6/ad3524f930c7f32640468b77/latest/USD";

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          exchangeRates = data['conversion_rates'];
          updateConvertedSaldo();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load exchange rates");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching exchange rates: $e");
    }
  }

  void updateConvertedSaldo() {
    if (exchangeRates != null) {
      setState(() {
        convertedSaldo =
            (exchangeRates![selectedCurrency] ?? 1.0) * enteredAmount;
      });
    }
  }

  void addSaldoToHive() {
    final saldoBox = Hive.box('saldoBox');
    double currentSaldo = saldoBox.get('saldo', defaultValue: 0.0);
    saldoBox.put('saldo', currentSaldo + convertedSaldo);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Saldo sebesar ${convertedSaldo.toStringAsFixed(2)} $selectedCurrency telah ditambahkan!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      appBar: AppBar(
        title: const Text(
          "Currency Exchange",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue, // Blue AppBar
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Exchange Currency",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Blue text for title
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Enter Amount',
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        enteredAmount = double.tryParse(value) ?? 0.0;
                        updateConvertedSaldo();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Converted Amount: ${convertedSaldo.toStringAsFixed(2)} $selectedCurrency",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    value: selectedCurrency,
                    isExpanded: true,
                    dropdownColor: Colors.blue[50], // Light blue dropdown menu
                    items: exchangeRates!.keys
                        .map<DropdownMenuItem<String>>((String key) {
                      return DropdownMenuItem<String>(
                        value: key,
                        child: Text(
                          key,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCurrency = value!;
                        updateConvertedSaldo();
                      });
                    },
                    style: const TextStyle(
                      color: Colors.blue, // Blue text in dropdown
                      fontSize: 16,
                    ),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: addSaldoToHive,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Blue button
                    ),
                    child: const Text("Add to Saldo"),
                  ),
                ],
              ),
            ),
    );
  }
}
