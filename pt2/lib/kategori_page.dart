import 'package:flutter/material.dart';

/// Halaman Kategori Hewan (KategoriPage),  Menggunakan StatelessWidget karena daftar kategori bersifat statis dan tidak berubah.
class KategoriPage extends StatelessWidget {
  const KategoriPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of Map yang menyimpan pasangan nama kategori dan ikonnya
    final categories = [
      {'name': 'Anjing', 'icon': Icons.pets},
      {'name': 'Kucing', 'icon': Icons.pets},
      {'name': 'Kelinci', 'icon': Icons.cruelty_free},
      {'name': 'Burung', 'icon': Icons.flutter_dash},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Hewan'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        // GridView.count membuat layout berbentuk kisi (grid) dengan jumlah kolom tetap
        child: GridView.count(
          crossAxisCount: 2, // Menampilkan 2 kolom secara horizontal
          crossAxisSpacing: 16, // Jarak horizontal antar item grid
          mainAxisSpacing: 16, // Jarak vertikal antar item grid
          // Mengubah setiap Map di List categories menjadi widget Container (Card Kategori)
          children: categories.map((category) {
            return Container(
              // Dekorasasi kartu kategori (Latar putih, sudut melengkung, & bayangan)
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 6,
                    offset: Offset(0, 3),
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Menyusun konten di tengah kartu secara vertikal
                children: [
                  // ikon kategori
                  Icon(
                    category['icon'] as IconData,
                    size: 60,
                    color: Colors.blue,
                  ),
                  
                  const SizedBox(height: 12),

                  // nama kategori
                  Text(
                    category['name'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(), // Mengubah hasil mapping iterable menjadi List<Widget>
        ),
      ),
    );
  }
}
