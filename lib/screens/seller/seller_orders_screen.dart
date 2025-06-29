import 'package:flutter/material.dart';
import '../../models/order_model.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import 'seller_menu_screen.dart';

class SellerOrdersScreen extends StatefulWidget {
  const SellerOrdersScreen({super.key});

  @override
  State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen> {
  String _selectedStatus = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load orders
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header biru
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 36, left: 18, right: 18, bottom: 18),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Pesanan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Image.asset('assets/images/logoputih.png', height: 20),
              ],
            ),
          ),
          // Card Atur Menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/lg.png', height: 32),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Atur Menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('Mau atur stok menu? Klik "Menu"', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SellerMenuScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      elevation: 0,
                    ),
                    child: const Text('Menu'),
                  ),
                ],
              ),
            ),
          ),
          // Teks instruksi
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Text(
              'Tekan tombol "Memasak" untuk memasak pesanan, lalu tekan tombol "Selesai" jika sudah menyelesaikan pesanan.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 8),
          // List pesanan
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
              children: [
                _orderCard(
                  context,
                  offline: true,
                  nama: 'Nasi Ayam Geprek',
                  gambar: 'assets/images/nasi_ayam.jpg',
                  kode: '#TRDKN2350',
                  waktu: '2024-01-13 12:54:20',
                  level: 'Level 1',
                  pembeli: 'Dwi Sartika',
                  catatan: 'Cth: Nasinya dikit',
                  meja: '23',
                  status: 'Pesanan menunggu diproses',
                ),
                _orderCard(
                  context,
                  offline: false,
                  nama: 'Nasi Ayam Geprek',
                  gambar: 'assets/images/nasi_ayam.jpg',
                  kode: '#TRDKN2350',
                  waktu: '2024-01-13 12:54:20',
                  level: 'Level 1',
                  pembeli: 'Dwi Sartika',
                  catatan: 'Cth: Nasinya dikit\nTambah Alat Makan',
                  meja: null,
                  status: 'Pesanan menunggu diproses',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderCard(
    BuildContext context, {
    required bool offline,
    required String nama,
    required String gambar,
    required String kode,
    required String waktu,
    required String level,
    required String pembeli,
    required String catatan,
    String? meja,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              gambar,
              width: 54,
              height: 54,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris atas: kode, waktu, status, x1
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(kode, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                          Text(waktu, style: const TextStyle(fontSize: 9, color: Colors.black45)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          offline ? 'Pesanan Offline' : 'Pesanan Online',
                          style: TextStyle(
                            color: offline ? Colors.black87 : AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text('x1', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info kiri
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text(level, style: const TextStyle(fontSize: 11, color: Colors.black87)),
                          Text('Pembeli : $pembeli', style: const TextStyle(fontSize: 11, color: Colors.black87)),
                        ],
                      ),
                    ),
                    // Info kanan
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Cth: $catatan', style: const TextStyle(fontSize: 11, color: Colors.black54)),
                        if (meja != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 1, bottom: 1),
                            child: Text('Meja : $meja', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black)),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status,
                          style: const TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 28,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFEB3B),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                          elevation: 0,
                        ),
                        child: const Text('Memasak'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String status) {
    final isSelected = _selectedStatus == status;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatus = status;
        });
      },
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Order _getMockOrder(int index) {
    final mockOrders = [
      Order(
        id: '1',
        customerId: 'customer1',
        sellerId: '1',
        courierId: '2',
        items: [
          OrderItem(
            productId: '1',
            productName: 'Laptop Gaming ASUS ROG',
            quantity: 1,
            price: 15000000,
          ),
        ],
        totalAmount: 15000000,
        status: OrderStatus.shipped,
        shippingAddress: 'Jl. Customer No. 789, Jakarta',
        trackingNumber: 'TRK001',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Order(
        id: '2',
        customerId: 'customer2',
        sellerId: '1',
        courierId: null,
        items: [
          OrderItem(
            productId: '2',
            productName: 'Smartphone Samsung Galaxy S24',
            quantity: 1,
            price: 12000000,
          ),
          OrderItem(
            productId: '3',
            productName: 'Sepatu Nike Air Max',
            quantity: 2,
            price: 2500000,
          ),
        ],
        totalAmount: 17000000,
        status: OrderStatus.confirmed,
        shippingAddress: 'Jl. Customer No. 456, Bandung',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
    
    return mockOrders[index % mockOrders.length];
  }
} 