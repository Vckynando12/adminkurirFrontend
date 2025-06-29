import 'package:flutter/material.dart';

class CourierHistoryDetailScreen extends StatelessWidget {
  const CourierHistoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Detail Pesanan', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Status Pengantaran
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 22),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Status Pengantaran', style: TextStyle(fontSize: 13, color: Colors.grey)),
                    Text('Selesai', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
              ],
            ),
          ),
          // Info Pesanan
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No. Pesanan', style: TextStyle(fontSize: 13, color: Colors.grey)),
                      Text('Waktu Pemesanan', style: TextStyle(fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('TRDKN2350', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    Text('13 Januari 2025 12:34:20', style: TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          // Info Pelanggan
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Informasi Pelanggan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: Text('Nama Pelanggan', style: TextStyle(fontSize: 13, color: Colors.grey))),
                    Expanded(child: Text('Dewi Sartika', style: TextStyle(fontSize: 13, color: Colors.black))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text('No Hp', style: TextStyle(fontSize: 13, color: Colors.grey))),
                    Expanded(child: Text('088855552222', style: TextStyle(fontSize: 13, color: Colors.black))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text('Alamat', style: TextStyle(fontSize: 13, color: Colors.grey))),
                    Expanded(child: Text('Gedung Teknologi Informasi', style: TextStyle(fontSize: 13, color: Colors.black))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text('Catatan Pengantaran', style: TextStyle(fontSize: 13, color: Colors.grey))),
                    Expanded(child: Text('Lantai 1 Ruang Baca JTI', style: TextStyle(fontSize: 13, color: Colors.black))),
                  ],
                ),
              ],
            ),
          ),
          // Daftar Pesanan
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pesanan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 8),
                _buildOrderItem(),
                const SizedBox(height: 8),
                _buildOrderItem(),
              ],
            ),
          ),
          // Info Pembayaran
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Informasi Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 8),
                _buildPaymentRow('Metode Pembayaran', 'Tunai', valueColor: Colors.blue),
                _buildPaymentRow('Biaya Pengiriman', 'Rp 20.000'),
                _buildPaymentRow('Total Pesanan', 'Rp 20.000'),
                _buildPaymentRow('Nominal uang pembeli', 'Rp 20.000'),
                _buildPaymentRow('Diskon', 'Rp 0'),
                _buildPaymentRow('Uang Kembali', 'Rp 0'),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text('Rp 22.000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color.fromARGB(255, 0, 0, 0))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/images/nasi_ayam.jpg', width: 60, height: 60, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Icon(Icons.person, color: Colors.blue, size: 28)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text('Nasi Ayam Geprek', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('Rp 10.000', style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 13)),
                    const Spacer(),
                    Text('x1', style: const TextStyle(fontSize: 13, color: Colors.black54)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text('Kantin 2', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                    ),
                    const Text('Status : ', style: TextStyle(fontSize: 13, color: Colors.blue)),
                    Text('Selesai', style: const TextStyle(fontSize: 13, color: Colors.blue, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          Text(value, style: TextStyle(fontSize: 13, color: valueColor ?? Colors.black)),
        ],
      ),
    );
  }
} 