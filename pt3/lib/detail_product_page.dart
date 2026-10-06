import 'package:flutter/material.dart';
import 'product.dart';

class DetailProductPage extends StatefulWidget {
  final Product product;
  final int availableStock; // stok yang masih bisa dibeli
  final void Function(int quantity) onAddToCart; // callback ke MainPage

  const DetailProductPage({
    super.key,
    required this.product,
    required this.availableStock,
    required this.onAddToCart,
  });

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  final TextEditingController quantityController =
  TextEditingController(text: '1');

  // STATE: pesan error validasi jumlah (null = input valid)
  String? errorText;

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  // Validasi dijalankan setiap teks berubah (mirip updateQuantity)
  void validateQuantity(String value) {
    final parsed = int.tryParse(value);
    String? error;
    if (parsed == null || parsed < 1) {
      error = 'Jumlah minimal 1';
    } else if (parsed > widget.availableStock) {
      error = 'Maksimal ${widget.availableStock}';
    }
    setState(() {
      errorText = error;
    });
  }

  void addToCart() {
    final quantity = int.parse(quantityController.text);
    // Ambil messenger sebelum pop, karena context halaman ini akan hilang
    final messenger = ScaffoldMessenger.of(context);

    widget.onAddToCart(quantity);
    Navigator.pop(context);

    messenger.showSnackBar(
      SnackBar(
        content: Text('${widget.product.name} ($quantity) ditambahkan ke keranjang'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    // STATE TURUNAN: tombol hanya aktif jika stok ada dan input valid
    final canAdd = widget.availableStock > 0 && errorText == null;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        offset: Offset(0, 4),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      product.imagePath,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Produk Pilihan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Text(
              formatRupiah(product.price),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Stok tersedia: ${widget.availableStock}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text('Jumlah', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              onChanged: validateQuantity,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Masukkan jumlah',
                errorText: errorText,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: canAdd ? addToCart : null,
                icon: const Icon(Icons.shopping_cart),
                label: Text(
                  widget.availableStock > 0
                      ? 'Tambah ke Keranjang'
                      : 'Stok Habis',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}