import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import 'courier_delivery_screen.dart';
import 'card_courier_history_detail_screen.dart';
import 'courier_capture_screen.dart';

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
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Container(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Badge/logo kiri
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text('#TRDKN2350', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                          const Spacer(),
                                          Text('x 2 menu', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      const Text('13 Januari 2025 12:34:20', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                      const SizedBox(height: 2),
                                      const Text('Dalam pengantaran', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Dua kolom label-isi
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Label kiri
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      SizedBox(height: 2),
                                      Text('Dipesan oleh', style: TextStyle(fontSize: 13, color: Colors.grey)),
                                      SizedBox(height: 8),
                                      Text('Alamat', style: TextStyle(fontSize: 13, color: Colors.grey)),
                                      SizedBox(height: 8),
                                      Text('Catatan', style: TextStyle(fontSize: 13, color: Colors.grey)),
                                      SizedBox(height: 8),
                                      Text('Biaya Pengiriman', style: TextStyle(fontSize: 13, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                // Isi kanan
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text('Dewi Sartika', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      const SizedBox(height: 8),
                                      const Text('Gedung Teknologi Informasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      const SizedBox(height: 8),
                                      const Text('Lantai 1 Ruang Baca JTI', style: TextStyle(fontSize: 13)),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.blue[50],
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Text('+ Rp 2.000', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Spacer(),
                                const Text('Rp 22.000', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 15)),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const CourierCaptureScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  child: const Text('Foto Bukti'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
    Widget cardContent = Container(
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
                              onPressed: buttonEnabled
                                  ? () {
                                      _showAntarDialog(context);
                                    }
                                  : null,
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
    // Jika orderId == '#TRDKN2350', bungkus dengan InkWell untuk navigasi ke detail
    if (orderId == '#TRDKN2350') {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CourierHistoryDetailScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: cardContent,
      );
    }
    return cardContent;
  }

  void _showAntarDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, size: 28, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Image.asset('assets/images/tanya.png', height: 110),
                const SizedBox(height: 16),
                const Text(
                  'Pesanan siap diantarkan?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tekan tombol "Ya" untuk mengkonfirmasi',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Tidak', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CourierDeliveryScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Ya', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 