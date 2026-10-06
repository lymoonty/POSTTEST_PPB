import 'package:flutter/material.dart';
import 'product.dart';
import 'home_page.dart';
import 'kategori_page.dart';
import 'cart_page.dart';
import 'profil_page.dart';
import 'checkout_success_page.dart';

void main() {
  runApp(const PetShopApp());
}

class PetShopApp extends StatelessWidget {
  const PetShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hiro PetShop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

// Semua state yang dipakai bersama (keranjang & stok) disimpan di sini, lalu halaman lain hanya menerima data + callback lewat constructor.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // STATE 1: halaman yang aktif di BottomNavigationBar
  int currentIndex = 0;

  // Data produk (tidak berubah)
  final List<Product> products = const [
    Product(
      id: 1,
      name: 'Dog Food Premium',
      description: 'Nature Gourmet Rasa Ayam',
      price: 272200,
      imagePath: 'assets/images/makanan_anjing.jpg',
      stock: 5,
      category: 'Anjing',
    ),
    Product(
      id: 2,
      name: 'Cat Food',
      description: 'Royal Canin Hair and Skin',
      price: 250000,
      imagePath: 'assets/images/makanan_kucing.jpg',
      stock: 3,
      category: 'Kucing',
    ),
  ];

  // STATE 2: stok saat ini per produk (berkurang setelah checkout)
  late final Map<int, int> stockById = {
    for (final p in products) p.id: p.stock,
  };

  // STATE 3: isi keranjang
  final List<CartItem> cart = [];

  //  STATE TURUNAN (dihitung dari state di atas)

  // Jumlah produk tertentu yang sudah ada di keranjang
  int quantityInCart(Product product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);
    return index == -1 ? 0 : cart[index].quantity;
  }

  // Stok yang masih bisa ditambahkan ke keranjang
  int availableStock(Product product) {
    return stockById[product.id]! - quantityInCart(product);
  }

  // Grand total, dipakai untuk mengaktifkan/menonaktifkan tombol Checkout
  int get grandTotal {
    return cart.fold(0, (sum, item) => sum + item.product.price * item.quantity);
  }

  // Total jumlah barang, dipakai untuk badge di icon keranjang
  int get totalItems {
    return cart.fold(0, (sum, item) => sum + item.quantity);
  }

  // FUNGSI YANG MENGUBAH STATE (memanggil setState)

  void addToCart(Product product, int quantity) {
    final qty = quantity.clamp(0, availableStock(product));
    if (qty <= 0) return;

    setState(() {
      final index = cart.indexWhere((item) => item.product.id == product.id);
      if (index == -1) {
        cart.add(CartItem(product: product, quantity: qty));
      } else {
        cart[index].quantity += qty;
      }
    });
  }

  void changeQuantity(Product product, int quantity) {
    setState(() {
      final index = cart.indexWhere((item) => item.product.id == product.id);
      if (index != -1) {
        cart[index].quantity = quantity.clamp(1, stockById[product.id]!);
      }
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      cart.removeWhere((item) => item.product.id == product.id);
    });
  }

  Future<void> checkout() async {
    final total = grandTotal;

    setState(() {
      // Kurangi stok permanen sesuai barang yang dibeli, lalu kosongkan keranjang
      for (final item in cart) {
        stockById[item.product.id] = stockById[item.product.id]! - item.quantity;
      }
      cart.clear();
    });

    // Tampilkan halaman sukses, tunggu sampai pengguna menekan "Kembali"
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutSuccessPage(total: total),
      ),
    );

    if (!mounted) return;
    setState(() {
      currentIndex = 0; // kembali ke Home
    });
  }

  @override
  Widget build(BuildContext context) {
    // Halaman dibuat di dalam build() (bukan const di field) supaya selalu menerima data terbaru setelah setState.
    final pages = <Widget>[
      HomePage(
        products: products,
        availableStock: availableStock,
        onAddToCart: addToCart,
        onOpenCart: () => setState(() => currentIndex = 2),
      ),
      const KategoriPage(),
      CartPage(
        items: cart,
        maxQuantityOf: (product) => stockById[product.id]!,
        onQuantityChanged: changeQuantity,
        onRemove: removeFromCart,
        onCheckout: checkout,
      ),
      const ProfilPage(),
    ];

    return Scaffold(
      // IndexedStack : semua halaman tetap hidup di memori, jadi teks pencarian & filter di Home tidak hilang saat pindah tab.
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            // Badge (Material 3): jumlah barang di keranjang, bergantung pada state cart
            icon: Badge(
              isLabelVisible: totalItems > 0,
              label: Text('$totalItems'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            label: 'Keranjang',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}