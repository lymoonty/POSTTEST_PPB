import 'package:flutter/material.dart';

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
            const CircleAvatar(
              radius: 45,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Pet Lover',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text('petlover@email.com'),

            const SizedBox(height: 30),

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

  Widget profileMenu(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(0, 2),
            color: Colors.black12,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}