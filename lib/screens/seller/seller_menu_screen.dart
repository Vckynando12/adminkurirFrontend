import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import 'seller_custom_order_screen.dart';

class SellerMenuScreen extends StatefulWidget {
  const SellerMenuScreen({super.key});

  @override
  State<SellerMenuScreen> createState() => _SellerMenuScreenState();
}

class _SellerMenuScreenState extends State<SellerMenuScreen> {
  // Dummy data status tersedia/habis
  final List<bool> available = [false, false, true, true, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header biru
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 36, left: 8, right: 18, bottom: 18),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 2),
                const Expanded(
                  child: Text(
                    'Menu Kantin',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Image.asset('assets/images/logoputih.png', height: 22),
              ],
            ),
          ),
          // Teks instruksi
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Text(
              'Untuk mengganti ketersediaan menu, silakan tekan tombol "Tersedia" atau "Habis".',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
          // List menu
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              itemCount: available.length,
              itemBuilder: (context, i) {
                return _menuCard(context, i);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuCard(BuildContext context, int i) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/nasi_ayam.jpg',
              width: 68,
              height: 68,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Nasi Ayam Geprek',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SellerCustomOrderScreen()),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(40, 24),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: const Text('Detail', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text('Rp 10.000', style: TextStyle(fontSize: 13, color: Colors.black87)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      height: 28,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => available[i] = !available[i]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: available[i] ? AppColors.primary : Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          elevation: 0,
                        ),
                        child: Text(available[i] ? 'Tersedia' : 'Habis'),
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
} 