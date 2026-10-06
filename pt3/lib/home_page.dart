import 'package:flutter/material.dart';
import 'product.dart';
import 'detail_product_page.dart';

// HomePage sekarang StatefulWidget karena punya data yang berubah:
// searchQuery (teks pencarian) dan selectedCategory (filter kategori).
class HomePage extends StatefulWidget {
  final List<Product> products;
  final int Function(Product) availableStock;
  final void Function(Product, int) onAddToCart;
  final VoidCallback onOpenCart;

  const HomePage({
    super.key,
    required this.products,
    required this.availableStock,
    required this.onAddToCart,
    required this.onOpenCart,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // STATE: kata kunci pencarian & kategori yang dipilih (null = semua)
  String searchQuery = '';
  String? selectedCategory;

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Anjing', 'icon': Icons.pets},
    {'name': 'Kucing', 'icon': Icons.pets},
    {'name': 'Kelinci', 'icon': Icons.cruelty_free},
    {'name': 'Burung', 'icon': Icons.flutter_dash},
  ];

  @override
  Widget build(BuildContext context) {
    // STATE TURUNAN: produk yang tampil dihitung dari searchQuery,
    // kategori, dan stok (stok habis = tidak ditampilkan).
    final visibleProducts = widget.products.where((product) {
      final inStock = widget.availableStock(product) > 0;
      final matchName = product.name.toLowerCase().contains(searchQuery);
      final matchCategory =
          selectedCategory == null || product.category == selectedCategory;
      return inStock && matchName && matchCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hiro PetShop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: widget.onOpenCart,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Halo, Pet Lovers! 🐾',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Temukan kebutuhan terbaik untuk hewan kesayanganmu.',
                ),
                const SizedBox(height: 20),

                // SEARCH: onChanged dipanggil setiap pengguna mengetik,
                // setState mengubah searchQuery lalu daftar produk dibangun ulang.
                TextField(
                  onChanged: (value) =>
                      setState(() => searchQuery = value.toLowerCase()),
                  decoration: InputDecoration(
                    hintText: 'Cari produk...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Kategori',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // KATEGORI: ditekan untuk memfilter, ditekan lagi untuk batal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: categories.map((category) {
                    final name = category['name'] as String;
                    return categoryCard(
                      category['icon'] as IconData,
                      name,
                      selectedCategory == name,
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Produk Populer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                if (visibleProducts.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(child: Text('Produk tidak ditemukan')),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: visibleProducts.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 320,
                    ),
                    itemBuilder: (context, index) {
                      return productCard(context, visibleProducts[index]);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryCard(IconData icon, String title, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = selected ? null : title;
        });
      },
      child: Container(
        width: 75,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.white,
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
            Icon(icon, size: 30, color: selected ? Colors.white : Colors.blue),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productCard(BuildContext context, Product product) {
    final available = widget.availableStock(product);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductPage(
              product: product,
              availableStock: available,
              onAddToCart: (quantity) =>
                  widget.onAddToCart(product, quantity),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                product.imagePath,
                width: double.infinity,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Text(
              formatRupiah(product.price),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Stok: $available',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            // Tombol aktif hanya jika stok tersedia (state turunan).
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: available > 0
                    ? () {
                  widget.onAddToCart(product, 1);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                      Text('${product.name} ditambahkan ke keranjang'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
                    : null,
                child: const FittedBox(
                  child: Text('Masukkan Keranjang'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}