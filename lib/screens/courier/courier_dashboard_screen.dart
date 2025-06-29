import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class CourierDashboardScreen extends StatefulWidget {
  const CourierDashboardScreen({super.key});

  @override
  State<CourierDashboardScreen> createState() => _CourierDashboardScreenState();
}

class _CourierDashboardScreenState extends State<CourierDashboardScreen> with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  int _navIndex = 0;

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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text('Pesanan Kurir', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Image.asset('assets/images/logo.png', height: 40),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Pendapatan
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 18, bottom: 8),
            child: Column(
              children: [
                Text('Rp 400.000', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue[600])),
                const SizedBox(height: 2),
                const Text('Total Pendapatan Kurir Hari Ini', style: TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),
          // Statistik
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                _buildStatCard('Perlu Diantar', '30', Icons.local_shipping, Colors.blue),
                const SizedBox(width: 8),
                _buildStatCard('Selesai', '22', Icons.check_circle, Colors.blue),
                const SizedBox(width: 8),
                _buildStatCard('Dibatalkan', '3', Icons.cancel, Colors.blue),
              ],
            ),
          ),
          // TabBar custom
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
                          children: [
                _buildTab('Untuk Dikirim', 0),
                _buildTab('Konfirmasi', 1),
                _buildTab('Dibatalkan', 2),
                      ],
                    ),
                  ),
          // List pesanan
          Expanded(
            child: Builder(
              builder: (context) {
                if (_tabIndex == 0) {
                  // Untuk Dikirim
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildOrderCard(
                        status: 'Belum diantar',
                        statusColor: Colors.red,
                        statusBg: Colors.transparent,
                        customer: 'Dewi Sartika',
                        address: 'Gedung Teknologi Informasi',
                        address2: 'Lantai 1 Ruang Baca JTI',
                        price: 'Rp 22.000',
                        badge: '+ Rp 2.000',
                        badgeColor: Colors.blue,
                        menuCount: 2,
                        buttonText: 'Antar',
                        buttonColor: Colors.blue,
                        buttonTextColor: Colors.white,
                        buttonEnabled: true,
                        logoAsset: 'assets/images/courier.png',
                        orderId: '#TRDKN2350',
                        date: '13 Januari 2025 12:34:20',
                      ),
                    ],
                  );
                } else if (_tabIndex == 1) {
                  // Konfirmasi
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Image.asset('assets/images/motor.jpg', height: 120),
                        const SizedBox(height: 24),
                        const Text(
                          'Belum ada pengantaran',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Selesaikan pengantaran pesanan dari penjual, lihat pada "Untuk Dikirim".',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Dibatalkan
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildOrderCard(
                        status: 'Dibatalkan oleh pelanggan',
                        statusColor: Colors.red,
                        statusBg: Colors.transparent,
                        customer: 'Ghea',
                        address: 'Gedung A3',
                        address2: 'Lantai 1 ketemu di lobby',
                        price: 'Rp 12.000',
                        badge: '+ Rp 2.000',
                        badgeColor: Colors.blue,
                        menuCount: 1,
                        buttonText: 'Dibatalkan',
                        buttonColor: Colors.grey[300]!,
                        buttonTextColor: Colors.white,
                        buttonEnabled: false,
                        logoAsset: 'assets/images/courier.png',
                        orderId: '#TRDKN2325',
                        date: '12 Januari 2025 12:34:20',
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey[300]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, int idx) {
    final active = _tabIndex == idx;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tabIndex = idx),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? Colors.blue : Colors.transparent,
                width: 3,
                    ),
                  ),
                ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: active ? Colors.blue : Colors.grey[500],
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String status,
    required Color statusColor,
    required Color statusBg,
    required String customer,
    required String address,
    required String address2,
    required String price,
    required String badge,
    required Color badgeColor,
    required int menuCount,
    required String buttonText,
    required Color buttonColor,
    required Color buttonTextColor,
    required bool buttonEnabled,
    required String logoAsset,
    required String orderId,
    required String date,
  }) {
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
                logoAsset,
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
                    Text(orderId, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900])),
                    const Spacer(),
                    Text('x $menuCount menu', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                // Tanggal di bawah orderId
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: Text(date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ),
                const SizedBox(height: 2),
                Text(status, style: TextStyle(color: statusColor, fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text('Nama Pelanggan : $customer', style: const TextStyle(fontSize: 13, color: Colors.black)),
                Text('Alamat : $address', style: const TextStyle(fontSize: 13, color: Colors.black)),
                Text('Cth   : $address2', style: const TextStyle(fontSize: 13, color: Colors.black)),
                const SizedBox(height: 2),
                Text('Biaya Pengiriman', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Row(
                  children: [
                    Text(price, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900], fontSize: 15)),
                    const Spacer(),
                    Flexible(
                      child: buttonText == 'Dibatalkan'
                          ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Text(
                                'Dibatalkan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: buttonEnabled ? () {} : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                foregroundColor: buttonTextColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                elevation: 0,
                              ),
                              child: Text(buttonText, style: const TextStyle(fontWeight: FontWeight.bold)),
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