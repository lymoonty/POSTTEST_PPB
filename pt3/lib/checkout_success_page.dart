import 'package:flutter/material.dart';
import 'product.dart';

// Halaman sukses setelah checkout.
class CheckoutSuccessPage extends StatelessWidget {
  final int total;

  const CheckoutSuccessPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                child: Icon(Icons.check, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text('Total', style: TextStyle(fontSize: 22)),
              const SizedBox(height: 8),
              Text(
                formatRupiah(total),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Kembali'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}