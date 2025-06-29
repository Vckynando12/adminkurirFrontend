import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class SellerCustomOrderScreen extends StatefulWidget {
  const SellerCustomOrderScreen({super.key});

  @override
  State<SellerCustomOrderScreen> createState() => _SellerCustomOrderScreenState();
}

class _SellerCustomOrderScreenState extends State<SellerCustomOrderScreen> {
  bool allowMultiple = false;
  int selectedLevel = 0;

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
              padding: const EdgeInsets.fromLTRB(12, 18, 18, 0),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Kustom Pemesanan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Nama menu dan harga
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: const [
                  Expanded(
                    child: Text('Nasi Ayam Geprek', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  ),
                  Text('Rp 10.000', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Section Level
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    child: Row(
                      children: [
                        const Text('Level', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                        const Spacer(),
                        Text('izinkan pilih lebih dari 1', style: TextStyle(fontSize: 11, color: Colors.black45)),
                        const SizedBox(width: 4),
                        Checkbox(
                          value: allowMultiple,
                          onChanged: (val) => setState(() => allowMultiple = val ?? false),
                          shape: const CircleBorder(),
                          activeColor: AppColors.primary,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // List pilihan level
                  ...List.generate(3, (i) => _levelOption(i)),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  child: const Text('Simpan Perubahan'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _levelOption(int i) {
    final levels = ['Level 0', 'Level 1', 'Level 2'];
    return InkWell(
      onTap: () => setState(() => selectedLevel = i),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(levels[i], style: const TextStyle(fontSize: 14)),
            ),
            const Text('+ Rp 0', style: TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(width: 8),
            Radio<int>(
              value: i,
              groupValue: selectedLevel,
              onChanged: (val) => setState(() => selectedLevel = val ?? 0),
              activeColor: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
} 