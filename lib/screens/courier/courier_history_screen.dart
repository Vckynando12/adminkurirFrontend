import 'package:flutter/material.dart';
import 'courier_history_detail_screen.dart';

class CourierHistoryScreen extends StatelessWidget {
  const CourierHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Riwayat', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) => _buildHistoryCard(context),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon bulat kiri (logo courier)
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/courier.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.person, color: Colors.blue, size: 28),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Info pesanan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('#TRDKN2350', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900])),
                    const Spacer(),
                    Text('x 2 menu', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: Text('13 Januari 2025 12:34:20', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                ),
                const Text('Selesai', style: TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                const Text('Nama Pembeli : Dwi Kartika', style: TextStyle(fontSize: 13, color: Colors.black)),
                const Text('Alamat : Gedung Teknologi Informasi', style: TextStyle(fontSize: 13, color: Colors.black)),
                const Text('Cth   : Lantai 1 Ruang Baca JTI', style: TextStyle(fontSize: 13, color: Colors.black)),
                const SizedBox(height: 2),
                const Text('Biaya Pengiriman', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Row(
                  children: [
                    const Text('Rp 22.000', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 15)),
                    const Spacer(),
                    SizedBox(
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CourierHistoryDetailScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                          elevation: 0,
                        ),
                        child: const Text('Lihat Detail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
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