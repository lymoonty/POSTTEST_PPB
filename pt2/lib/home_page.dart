import 'package:flutter/material.dart';
import 'detail_product_page.dart';
import 'cart_page.dart';

// halaman utama aplikasi, stateless widget krna lom dinamis 
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hiro PetShop'),
        actions: [
          // Tombol Ikon Keranjang untuk Navigasi ke CartPage
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
          ),
        ],
      ),

      // SafeArea memastikan konten tidak tertutup notch/status bar perangkat
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GREETING
                const Text(
                  'Halo, Pet Lovers! 🐾',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Temukan kebutuhan terbaik untuk hewan kesayanganmu.',
                ),

                const SizedBox(height: 20),

                // form pencarian
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari produk...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // filter produk
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        offset: Offset(0, 3),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.filter_list),
                      SizedBox(width: 10),
                      Text(
                        'Filter Produk',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Kategori
                const Text(
                  'Kategori',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // baris card kategori hewan 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    categoryCard(Icons.pets, 'Anjing'),
                    categoryCard(Icons.pets, 'Kucing'),
                    categoryCard(Icons.cruelty_free, 'Kelinci'),
                    categoryCard(Icons.flutter_dash, 'Burung'),
                  ],
                ),

                const SizedBox(height: 24),

                // PRODUK POPULER
                const Text(
                  'Produk Populer',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Grid/Baris Produk Menggunakan Expanded Agar Pembagian Lebar Seimbang (50:50)
                Row(
                  children: [
                    // dog food
                    Expanded(
                      child: productCard(
                        context,
                        'Dog Food Premium',
                        'Nature Gourmet Rasa Ayam',
                        '272.200',
                        'assets/images/makanan_anjing.jpg',
                      ),
                    ),

                    const SizedBox(width: 12),

                    // cat food
                    Expanded(
                      child: productCard(
                        context,
                        'Cat Food',
                        'Royal Canin Hair and Skin',
                        '250.000',
                        'assets/images/makanan_kucing.jpg',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper Method untuk membuat Kartu Kategori (`categoryCard`) Bersifat reusable untuk setiap ikon dan judul kategori hewan.
  Widget categoryCard(
      IconData icon,
      String title,
      ) {
    return Container(
      width: 75,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(0, 2),
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.blue,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Helper Method untuk membuat Kartu Produk Populer (`productCard`) Dilengkapi fungsi `GestureDetector` untuk navigasi ke `DetailProductPage` saat diklik.
  Widget productCard(
      BuildContext context,
      String name,
      String description,
      String price,
      String imagePath,
      ) {
    return GestureDetector(
      // Aksi saat kartu produk di-tap / diklik oleh pengguna
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductPage(
              name: name,
              description: description,
              price: price,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
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
        child: Stack(
          children: [
            // Layout Isi Utama Kartu (Gambar, Nama, Deskripsi, Harga)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // GAMBAR PRODUK
                ClipRRect(
                  borderRadius: BorderRadius.circular(12), // memotong sudut gambar
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 10),

                // NAMA PRODUK
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                // DESKRIPSI
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 8),

                // HARGA
                Text(
                  'Rp $price',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            // LABEL POPULER
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Populer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
