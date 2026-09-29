import 'package:flutter/material.dart';
import 'home_page.dart';
import 'kategori_page.dart';
import 'cart_page.dart';
import 'profil_page.dart';

void main() {
  runApp(const PetShopApp());
}

class PetShopApp extends StatelessWidget {
  const PetShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Menghilangkan tulisan DEBUG pada pojok kanan atas
      debugShowCheckedModeBanner: false,

      // Menentukan judul aplikasi
      title: 'Hiro PetShop',

      // Mengatur tema umum aplikasi
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),

      // Menentukan halaman utama aplikasi
      home: const MainPage(),
    );
  }
}

// MainPage digunakan sebagai pembungkus halaman dan BottomNavigationBar
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Menentukan halaman yang sedang aktif
  int currentIndex = 0;

  // Daftar halaman yang digunakan pada BottomNavigationBar
  final List<Widget> pages = const [
    HomePage(),
    KategoriPage(),
    CartPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menampilkan halaman sesuai dengan index yang dipilih
      body: pages[currentIndex],

      // BottomNavigationBar digunakan sebagai navigasi bagian bawah
      bottomNavigationBar: BottomNavigationBar(
        // Menentukan item yang sedang aktif
        currentIndex: currentIndex,

        // Warna icon dan label yang sedang dipilih
        selectedItemColor: Colors.blue,

        // Warna icon dan label yang tidak dipilih
        unselectedItemColor: Colors.grey,

        // Berpindah halaman ketika item ditekan
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        // Item navigasi
        items: const [
          // Item Home
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),

          // Item Kategori
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category_outlined,
            ),
            label: 'Kategori',
          ),

          // Item Keranjang
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
            label: 'Keranjang',
          ),

          // Item Profil
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
