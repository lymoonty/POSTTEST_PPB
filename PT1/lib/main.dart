import 'package:flutter/material.dart';

void main() {
runApp(const PetShopApp());
}

// MaterialApp digunakan sebagai widget utama pembungkus aplikasi Flutter
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

// Menentukan halaman pertama yang ditampilkan
home: const HomePage(),
);
}
}


// Halaman utama PetShop
class HomePage extends StatelessWidget {
const HomePage({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
// Mengatur warna background halaman
backgroundColor: Colors.white,

// AppBar digunakan sebagai bagian atas halaman
appBar: AppBar(
// Judul aplikasi pada AppBar
title: const Text(
'Hiro PetShop',
style: TextStyle(
fontWeight: FontWeight.bold,
),
),

// Mengatur warna AppBar
backgroundColor: Colors.blue.shade100,

// Icon keranjang belanja
actions: const [
Icon(
Icons.shopping_cart_outlined,
size: 25,
),

// SizedBox digunakan untuk memberikan jarak
SizedBox(width: 16),
],
),

// SafeArea digunakan agar isi halaman tidak tertutup area perangkat
body: SafeArea(
child: SingleChildScrollView(
// SingleChildScrollView membuat halaman dapat di-scroll
child: Padding(
// Padding memberikan jarak antara isi dengan tepi layar
padding: const EdgeInsets.all(20),

// Column digunakan untuk menyusun widget secara vertikal
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

// Text digunakan untuk menampilkan teks sapaan
const Text(
'Halo, Pet Lovers!',
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
),
),

// SizedBox memberikan jarak vertikal
const SizedBox(height: 5),

// Text untuk deskripsi singkat
Text(
'Temukan kebutuhan terbaik untuk hewan kesayanganmu.',
style: TextStyle(
fontSize: 14,
color: Colors.grey.shade600,
),
),

// SizedBox memberikan jarak sebelum search bar
const SizedBox(height: 20),

// Row digunakan untuk menyusun widget secara horizontal
Row(
children: [

// Expanded membuat TextField memenuhi sisa ruang Row
Expanded(
child: TextField(
// TextField digunakan sebagai input pencarian
decoration: InputDecoration(
// HintText menampilkan teks petunjuk
hintText: 'Cari kebutuhan hewan...',

// Icon pencarian pada bagian kiri TextField
prefixIcon: const Icon(
Icons.search,
),

// Mengatur tampilan TextField
filled: true,
fillColor: Colors.grey.shade100,

// Mengatur bentuk TextField
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(15),
borderSide: BorderSide.none,
),
),
),
),

// SizedBox memberikan jarak antara search dan filter
const SizedBox(width: 10),

// Container digunakan untuk membuat tombol filter
Container(
// Mengatur ukuran Container
width: 52,
height: 52,

// Mengatur tampilan Container
decoration: BoxDecoration(
color: Colors.blue,
borderRadius: BorderRadius.circular(15),
),

// Icon digunakan untuk menampilkan icon filter
child: const Icon(
Icons.tune,
color: Colors.white,
),
),
],
),

// SizedBox memberikan jarak menuju kategori
const SizedBox(height: 30),

// Row untuk judul kategori
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [

// Text judul kategori
const Text(
'Kategori',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

// Text untuk pilihan melihat semua kategori
Text(
'Lihat Semua',
style: TextStyle(
color: Colors.blue.shade700,
fontWeight: FontWeight.w500,
),
),
],
),

// SizedBox memberikan jarak
const SizedBox(height: 15),

// Row digunakan untuk menampilkan kategori
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [

// Container kategori anjing
Container(
width: 70,
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: Colors.yellow.shade50,
borderRadius: BorderRadius.circular(15),
),
child: const Column(
children: [

// Icon anjing
Icon(
Icons.pets,
size: 30,
color: Colors.yellow,
),

// SizedBox memberikan jarak
SizedBox(height: 5),

// Text nama kategori
Text(
'Anjing',
style: TextStyle(fontSize: 12),
),
],
),
),

// Container kategori kucing
Container(
width: 70,
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: Colors.blue.shade50,
borderRadius: BorderRadius.circular(15),
),
child: const Column(
children: [

// Icon kucing
Icon(
Icons.pets,
size: 30,
color: Colors.blue,
),

// SizedBox memberikan jarak
SizedBox(height: 5),

// Text nama kategori
Text(
'Kucing',
style: TextStyle(fontSize: 12),
),
],
),
),

// Container kategori kelinci
Container(
width: 70,
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: Colors.orange.shade50,
borderRadius: BorderRadius.circular(15),
),
child: const Column(
children: [

// Icon kelinci
Icon(
Icons.cruelty_free,
size: 30,
color: Colors.orange,
),

// SizedBox memberikan jarak
SizedBox(height: 5),

// Text nama kategori
Text(
'Kelinci',
style: TextStyle(fontSize: 12),
),
],
),
),

// Container kategori burung
Container(
width: 70,
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: Colors.pink.shade50,
borderRadius: BorderRadius.circular(15),
),
child: const Column(
children: [

// Icon burung
Icon(
Icons.flutter_dash,
size: 30,
color: Colors.pink,
),

// SizedBox memberikan jarak
SizedBox(height: 5),

// Text nama kategori
Text(
'Burung',
style: TextStyle(fontSize: 12),
),
],
),
),
],
),

// SizedBox memberikan jarak
const SizedBox(height: 30),

// Row untuk judul produk
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [

// Text judul produk
const Text(
'Produk Populer',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

// Text pilihan melihat semua produk
Text(
'Lihat Semua',
style: TextStyle(
color: Colors.blue.shade700,
fontWeight: FontWeight.w500,
),
),
],
),

// SizedBox memberikan jarak
const SizedBox(height: 15),

// Row digunakan untuk menyusun card produk
Row(
children: [

// Expanded membuat produk pertama memiliki ukuran seimbang
Expanded(
child: productCard(
Icons.pets,
'Dog Food Premium',
'Makanan anjing berkualitas',
'Rp85.000',
),
),

// SizedBox memberikan jarak antar produk
const SizedBox(width: 12),

// Expanded membuat produk kedua memiliki ukuran seimbang
Expanded(
child: productCard(
Icons.set_meal,
'Cat Food Tuna',
'Makanan kucing rasa tuna',
'Rp65.000',
),
),
],
),

// SizedBox memberikan jarak bawah
const SizedBox(height: 20),
],
),
),
),
),

// BottomNavigationBar digunakan sebagai navigasi bagian bawah
bottomNavigationBar: BottomNavigationBar(
currentIndex: 0,
selectedItemColor: Colors.blue,
unselectedItemColor: Colors.grey,

// Item navigasi
items: const [

// Item Home
BottomNavigationBarItem(
icon: Icon(
Icons.home,
),
label: 'Home',
),

// Item kategori
BottomNavigationBarItem(
icon: Icon(
Icons.category_outlined,
),
label: 'Kategori',
),

// Item keranjang
BottomNavigationBarItem(
icon: Icon(
Icons.shopping_cart_outlined,
),
label: 'Keranjang',
),

// Item profil
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

// Function untuk membuat card produk agar kode tidak berulang
Widget productCard(
IconData icon,
String name,
String description,
String price,
) {
// Container digunakan sebagai card produk
return Container(
padding: const EdgeInsets.all(12),

// BoxDecoration mengatur warna dan bentuk card
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(15),

// Memberikan garis tepi pada card
border: Border.all(
color: Colors.grey.shade200,
),
),

// Column menyusun isi card secara vertikal
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

// Container untuk area icon produk
Container(
width: double.infinity,
height: 100,

decoration: BoxDecoration(
color: Colors.blue.shade50,
borderRadius: BorderRadius.circular(12),
),

// Icon produk
child: Icon(
icon,
size: 50,
color: Colors.blue,
),
),

// SizedBox memberikan jarak
const SizedBox(height: 10),

// Text nama produk
Text(
name,
style: const TextStyle(
fontSize: 15,
fontWeight: FontWeight.bold,
),
),

// SizedBox memberikan jarak
const SizedBox(height: 5),

// Text deskripsi produk
Text(
description,
style: TextStyle(
fontSize: 11,
color: Colors.grey.shade600,
),
),

// SizedBox memberikan jarak
const SizedBox(height: 8),

// Text harga produk
Text(
price,
style: const TextStyle(
fontSize: 15,
fontWeight: FontWeight.bold,
color: Colors.blueGrey,
),
),
],
),
);
}
}
