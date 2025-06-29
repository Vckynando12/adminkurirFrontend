import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';
import '../../utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(context, listen: false).loadOrders();
      Provider.of<ProductProvider>(context, listen: false).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer3<AuthProvider, OrderProvider, ProductProvider>(
        builder: (context, authProvider, orderProvider, productProvider, child) {
          final user = authProvider.currentUser;
          if (user == null) return const SizedBox.shrink();

          final sellerOrders = orderProvider.getOrdersBySeller(user.id);
          const selesai = 0;
          const dilayani = 0;
          const dibatalkan = 0;
          final totalMenu = productProvider.products.length;
          final lowStockProducts = productProvider.products.where((product) => product.stock < 5).length;

          // Dummy data
          final pendapatanHariIni = 200000;
          final pendapatanBulanan = 1200000;

          return SafeArea(
            child: Stack(
              children: [
                // Multi-layer wave background
                SizedBox(
                  width: double.infinity,
                  height: 240,
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: _WaveClipper3(),
                        child: Container(
                          height: 240,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.primary.withOpacity(0.5), AppColors.secondary.withOpacity(0.4)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ),
                      ClipPath(
                        clipper: _WaveClipper2(),
                        child: Container(
                          height: 210,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.primary.withOpacity(0.7), AppColors.secondary.withOpacity(0.6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ),
                      ClipPath(
                        clipper: _WaveClipper(),
                        child: Container(
                          height: 180,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.primary, AppColors.secondary],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Konten utama
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      // Logo dan nama aplikasi di dalam area biru
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logoputih.png',
                            height: 20,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Text(
                                '',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      // Card Pendapatan mengambang
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.receipt_long, color: Colors.white, size: 22),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Total Pendapatan Hari Ini',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFB3E5FC), // biru muda solid
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Color(0xFFB3E5FC), width: 2), // outline biru muda
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Rp ${pendapatanHariIni.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (m) => "${m[1]}.")}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Total Pendapatan Bulanan',
                                        style: TextStyle(color: Colors.white70, fontSize: 13),
                                      ),
                                      Text(
                                        'Rp ${pendapatanBulanan.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (m) => "${m[1]}.")}',
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      const Text('Buka Kantin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                                      const SizedBox(width: 6),
                                      _CustomToggle(),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Statistik Transaksi Hari Ini
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _statCard('Selesai', 30, Colors.blue),
                            _statCard('Dilayani', 22, Colors.blue),
                            _statCard('Dibatalkan', 3, Colors.blue),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Sebelum card Total Menu
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4, bottom: 4),
                          child: Text(
                            'Total Menu',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      // Total Menu
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/lg.png', height: 28),
                            const SizedBox(width: 10),
                            Text('8 Menu', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 16)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Grafik Penjualan
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Grafik Penjualan Setiap Bulan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 180,
                              child: LineChart(
                                LineChartData(
                                  gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 1),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 40,
                                        getTitlesWidget: (value, meta) {
                                          switch (value.toInt()) {
                                            case 0:
                                              return const Text('0');
                                            case 3:
                                              return const Text('3 jt');
                                            case 6:
                                              return const Text('6 jt');
                                            case 8:
                                              return const Text('8 jt');
                                            case 10:
                                              return const Text('10 jt');
                                            default:
                                              return const SizedBox.shrink();
                                          }
                                        },
                                        interval: 1,
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          if (value >= 0 && value < 12) {
                                            return Text('${value.toInt() + 1}', style: const TextStyle(fontSize: 11));
                                          }
                                          return const SizedBox.shrink();
                                        },
                                        interval: 1,
                                      ),
                                    ),
                                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  ),
                                  borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey[300]!)),
                                  minX: 0,
                                  maxX: 11,
                                  minY: 0,
                                  maxY: 10,
                                  lineBarsData: [
                                    LineChartBarData(
                                      isCurved: false,
                                      color: Color(0xFF29B6F6),
                                      barWidth: 2,
                                      dotData: FlDotData(show: true),
                                      belowBarData: BarAreaData(show: false),
                                      spots: const [
                                        FlSpot(0, 6),
                                        FlSpot(1, 8),
                                        FlSpot(2, 3),
                                        FlSpot(3, 9),
                                        FlSpot(4, 5),
                                        FlSpot(5, 4),
                                        FlSpot(6, 3),
                                        FlSpot(7, 4),
                                        FlSpot(8, 5),
                                        FlSpot(9, 6),
                                        FlSpot(10, 7),
                                        FlSpot(11, 3),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Alerts
                      if (lowStockProducts > 0) ...[
                        Container(
                          padding: const EdgeInsets.all(AppSizes.paddingMedium),
                          decoration: BoxDecoration(
                            color: AppColors.warning.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                            border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: AppColors.warning,
                                size: 24,
                              ),
                              const SizedBox(width: AppSizes.paddingMedium),
                              Expanded(
                                child: Text(
                                  '$lowStockProducts produk dengan stok rendah',
                                  style: TextStyle(
                                    color: AppColors.warning,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard(String label, int value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87)),
            const SizedBox(height: 6),
            Text('$value', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, size.height - 30, size.width / 2, size.height - 10);
    path.quadraticBezierTo(size.width * 3 / 4, 0, size.width, 30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.85);
    path.quadraticBezierTo(size.width / 4, size.height * 0.75, size.width / 2, size.height * 0.85);
    path.quadraticBezierTo(size.width * 3 / 4, size.height, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width / 4, size.height * 0.9, size.width / 2, size.height * 0.7);
    path.quadraticBezierTo(size.width * 3 / 4, size.height * 0.5, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _CustomToggle extends StatefulWidget {
  @override
  State<_CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<_CustomToggle> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isOn = !isOn),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 38,
        height: 22,
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        decoration: BoxDecoration(
          color: isOn ? const Color(0xFFB3E5FC) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFB3E5FC), width: 2),
        ),
        child: Align(
          alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: isOn ? Colors.white : const Color(0xFFB3E5FC),
              shape: BoxShape.circle,
              boxShadow: [
                if (isOn)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}