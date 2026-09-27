import 'package:flutter/material.dart';

class KategoriPage extends StatelessWidget {
  const KategoriPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: categories.map((category) {
            return Container(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    size: 60,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 12),
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
          }).toList(),
        ),
      ),
    );
  }
}
