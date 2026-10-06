import 'package:flutter/material.dart';
import 'product.dart';

// CartPage hanya menampilkan data dari MainPage, jadi cukup StatelessWidget. Perubahan data dikirim balik ke MainPage lewat callback.
class CartPage extends StatelessWidget {
  final List<CartItem> items;
  final int Function(Product) maxQuantityOf;
  final void Function(Product, int) onQuantityChanged;
  final void Function(Product) onRemove;
  final VoidCallback onCheckout;

  const CartPage({
    super.key,
    required this.items,
    required this.maxQuantityOf,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    // STATE TURUNAN: grand total dihitung dari isi keranjang
    final grandTotal = items.fold<int>(
      0,
          (sum, item) => sum + item.product.price * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: Column(
        children: [
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Keranjang masih kosong'))
                : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (context, index) =>
              const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                return CartProductCard(
                  // key agar State tiap kartu tidak tertukar saat item dihapus
                  key: ValueKey(item.product.id),
                  product: item.product,
                  quantity: item.quantity,
                  maxQuantity: maxQuantityOf(item.product),
                  onQuantityChanged: (value) =>
                      onQuantityChanged(item.product, value),
                  onRemove: () => onRemove(item.product),
                );
              },
            ),
          ),

          // Bar total + checkout di bagian bawah
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  offset: Offset(0, -2),
                  color: Colors.black12,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total'),
                      Text(
                        formatRupiah(grandTotal),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                // Nonaktif jika keranjang kosong (grandTotal == 0)
                ElevatedButton(
                  onPressed: grandTotal > 0 ? onCheckout : null,
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// CartProductCard stateful karena punya TextEditingController untuk input jumlah.
class CartProductCard extends StatefulWidget {
  final Product product;
  final int quantity;
  final int maxQuantity;
  final void Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartProductCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.maxQuantity,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  late TextEditingController quantityController;

  // initState: dijalankan sekali, mengisi controller dengan jumlah awal
  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController(text: '${widget.quantity}');
  }

  // didUpdateWidget: menyamakan isi TextField bila quantity berubah dari luar (misalnya lewat tombol + / -)
  @override
  void didUpdateWidget(covariant CartProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity &&
        quantityController.text != '${widget.quantity}') {
      quantityController.text = '${widget.quantity}';
    }
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  // Validasi input: ubah teks jadi angka, batasi 1..maxQuantity, lalu kirim ke MainPage lewat callback (setState dilakukan di sana).
  void updateQuantity(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 1) return;

    final clamped = parsed.clamp(1, widget.maxQuantity);
    // Jika input melebihi stok, kembalikan teks ke batas maksimal
    if (clamped != parsed) {
      quantityController.text = '$clamped';
    }
    widget.onQuantityChanged(clamped);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Container(
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
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(product.imagePath, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(formatRupiah(product.price)),
                const SizedBox(height: 2),
                Text(
                  'Maks. ${widget.maxQuantity}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 56,
            child: TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: updateQuantity,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onRemove,
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }
}