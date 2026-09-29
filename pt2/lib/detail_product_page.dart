import 'package:flutter/material.dart';

// halaman detail produk 
/// Menggunakan StatefulWidget karena mengelola state lokal berupa controller teks (`TextEditingController`).
class DetailProductPage extends StatefulWidget {
  // data produk yang dikirim dari halaman sebelumnya 
  final String name;
  final String description;
  final String price;
  final String imagePath;

  const DetailProductPage({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  // Controller untuk mengontrol dan mengambil nilai inputan jumlah produk (default nilai: '1')
  final TextEditingController quantityController =
  TextEditingController(text: '1');

  @override
  void dispose() {
    // membersihkan controller dari memori widget saat widget dihncurkan agar tidak memory leak
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        // tombol kembali ke halaman sebelmnya
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // mengatur smwa elemen rata kiri 
          children: [

            // GAMBAR PRODUK
            Stack(
              children: [
                // box container latar belakang gmbr dgn efek shadow
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
                  // ClipRRect memotong gambar agar sudutnya melengkung mengikuti border radius
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      widget.imagePath,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.contain, // Memastikan gambar muat di dalam box tanpa terpotong
                    ),
                  ),
                ),

                // LABEL PRODUK PILIHAN
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

            // NAMA PRODUK
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // DESKRIPSI
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

            // HARGA
            Text(
              'Rp ${widget.price}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 24),

            // JUMLAH
            const Text(
              'Jumlah',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan jumlah',
              ),
            ),

            const SizedBox(height: 20),

            // TOMBOL TAMBAH KE KERANJANG
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Tambah ke Keranjang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
