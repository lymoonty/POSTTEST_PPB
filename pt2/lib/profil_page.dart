import 'package:flutter/material.dart';

/// Halaman Profil Pengguna (ProfilPage), Menggunakan StatelessWidget karena seluruh tampilan bersifat statis dan belum terhubung ke State Management.
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // CircleAvatar membuat komponen gambar/ikon berbentuk lingkaran
            const CircleAvatar(
              radius: 45, // Ukuran jari-jari lingkaran
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 12),

            // informasi oengguna
            // Nama Pengguna
            const Text(
              'Pet Lover',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            // Email Pengguna
            const Text('petlover@email.com'),

            const SizedBox(height: 30),

            // daftar menu profil
            // Pemanggilan method helper profileMenu untuk masing-masing opsi menu
            profileMenu(
              Icons.person_outline,
              'Edit Profil',
            ),
            profileMenu(
              Icons.history,
              'Riwayat Pesanan',
            ),
            profileMenu(
              Icons.settings_outlined,
              'Pengaturan',
            ),
            profileMenu(
              Icons.help_outline,
              'Bantuan',
            ),
          ],
        ),
      ),
    );
  }

  /// Helper Method untuk membuat item Menu Profil (`profileMenu`)
  Widget profileMenu(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Jarak antar item menu di bagian bawah
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        // Efek bayangan pada setiap kartu menu
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(0, 2),
            color: Colors.black12,
          ),
        ],
      ),
      // ListTile menyediakan struktur standar untuk item list (Ikon Kiri, Teks, Ikon Kanan)
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue, // Ikon utama di sebelah kiri
        ),
        title: Text(title), // Judul menu
        trailing: const Icon(Icons.chevron_right), // Ikon panah petunjuk di sebelah kanan
        onTap: () {
        },
      ),
    );
  }
}
