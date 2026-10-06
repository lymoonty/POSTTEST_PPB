// Model data produk. Sebelumnya data produk ditulis langsung (hardcode) di setiap halaman, sekarang disatukan di sini supaya harga & stok konsisten.
class Product {
  final int id;
  final String name;
  final String description;
  final int price; // disimpan sebagai angka agar bisa dihitung (total)
  final String imagePath;
  final int stock; // stok awal
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.stock,
    required this.category,
  });
}

// Item di keranjang: produk + jumlah yang dibeli. quantity tidak final karena nilainya berubah (diubah lewat setState di MainPage).
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

// Mengubah 272200 menjadi "Rp 272.200"
String formatRupiah(int value) {
  final s = value.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buffer.write('.');
    buffer.write(s[i]);
  }
  return 'Rp $buffer';
}