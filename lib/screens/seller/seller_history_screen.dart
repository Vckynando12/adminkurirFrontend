import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class SellerHistoryScreen extends StatefulWidget {
  const SellerHistoryScreen({super.key});

  @override
  State<SellerHistoryScreen> createState() => _SellerHistoryScreenState();
}

class _SellerHistoryScreenState extends State<SellerHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedFilter = 0;
  int selectedDate = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
              child: Text(
                'Riwayat Pesanan',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            // Tab Bar
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 0, right: 0),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.black54,
                indicatorColor: AppColors.primary,
                indicatorWeight: 3,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                tabs: const [
                  Tab(text: 'Riwayat'),
                  Tab(text: 'RPH'),
                  Tab(text: 'RHP'),
                ],
              ),
            ),
            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab 1: Riwayat
                  _riwayatTab(),
                  // Tab 2: RPH
                  _rphTab(),
                  // Tab 3: RHP
                  _rhpTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _riwayatTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total Keseluruhan
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Center(
            child: Column(
              children: const [
                Text(
                  'Rp 2.400.000',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Total Keseluruhan',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        // Filter dan List Riwayat
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
          child: Row(
            children: [
              const Text('List Riwayat', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const Spacer(),
              DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: selectedFilter,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Semua')),
                    DropdownMenuItem(value: 1, child: Text('Selesai')),
                    DropdownMenuItem(value: 2, child: Text('Batal')),
                  ],
                  onChanged: (val) {
                    setState(() => selectedFilter = val ?? 0);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // ListView
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            itemCount: 4,
            itemBuilder: (context, i) {
              return _historyCard();
            },
          ),
        ),
      ],
    );
  }

  Widget _rphTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Info box biru
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.info, color: AppColors.primary, size: 22),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'RPH (Rekap Pendapatan Harian) berguna untuk merekap semua pendapatan Anda setiap harinya. Untuk melihat RPH berdasarkan hari tertentu, pilih tanggal sesuai yang Anda ingin lihat',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Total Saldo
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
          child: Row(
            children: const [
              Text('Total Saldo', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              Spacer(),
              Text('Rp 800.000', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
        // Tanggal filter
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: Row(
            children: [
              const Text('Tanggal', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const Spacer(),
              DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: selectedDate,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('19-03-2025 - 20-03-2025')),
                    DropdownMenuItem(value: 1, child: Text('18-03-2025 - 19-03-2025')),
                  ],
                  onChanged: (val) {
                    setState(() => selectedDate = val ?? 0);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // List RPH
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            itemCount: 2,
            itemBuilder: (context, i) {
              return _rphCard();
            },
          ),
        ),
      ],
    );
  }

  Widget _rhpTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Info box biru
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.info, color: AppColors.primary, size: 22),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'RHP (Rekap Harian Produk) berguna untuk merekap semua pendapatan Anda dari setiap produk yang terjual. Untuk melihat RHP berdasarkan hari tertentu, pilih tanggal sesuai yang Anda ingin lihat',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Total Saldo
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
          child: Row(
            children: const [
              Text('Total Saldo', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              Spacer(),
              Text('Rp 800.000', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
        // Tanggal filter
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: Row(
            children: [
              const Text('Tanggal', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const Spacer(),
              DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: selectedDate,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('19-03-2025 - 20-03-2025')),
                    DropdownMenuItem(value: 1, child: Text('18-03-2025 - 19-03-2025')),
                  ],
                  onChanged: (val) {
                    setState(() => selectedDate = val ?? 0);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // List RHP
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            itemCount: 2,
            itemBuilder: (context, i) {
              return _rhpCard();
            },
          ),
        ),
      ],
    );
  }

  Widget _historyCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // Circle icon biru
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primary,
            child: const Text('KP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text('Nomor Transaksi : TRDKN2350', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 2),
                const Text('Tanggal Pemesanan : 2024-01-13 12:54:20', style: TextStyle(fontSize: 11, color: Colors.black54)),
                const SizedBox(height: 6),
                const Text('Pembayaran : Tunai', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 2),
                Row(
                  children: const [
                    Expanded(child: Text('Nasi Ayam Geprek', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                    Text('Rp 10.000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    SizedBox(width: 8),
                    Text('x2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 2),
                const Text('Rp 20.000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 2),
                const Text('Pesanan Offline', style: TextStyle(fontSize: 11, color: Colors.black87)),
                const SizedBox(height: 2),
                Row(
                  children: const [
                    Text('Status : ', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text('Selesai', style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rphCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('Tgl : 2025-03-19 | 10 Transaksi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Spacer(),
              Text('Rp 20.000', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Expanded(child: Text('VIRTUAL ACCOUNT', style: TextStyle(fontSize: 12, color: Colors.black54))),
              Text('Rp 0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: const [
              Expanded(child: Text('E-WALLET', style: TextStyle(fontSize: 12, color: Colors.black54))),
              Text('Rp 40.000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: const [
              Expanded(child: Text('TUNAI', style: TextStyle(fontSize: 12, color: Colors.black54))),
              Text('Rp 67.000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rhpCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Text('Kode Produk : 211', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Spacer(),
              Text('Rp 400.000', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          SizedBox(height: 8),
          Text('Nama   : Nasi Ayam Geprek', style: TextStyle(fontSize: 13)),
          Text('Harga  : Rp 10.000', style: TextStyle(fontSize: 13)),
          Text('Jumlah yang terjual : 40 item', style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
} 