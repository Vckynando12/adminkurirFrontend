import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  final TextEditingController usernameController = TextEditingController(text: 'Kantin1');
  final TextEditingController ownerController = TextEditingController(text: 'Bu Djoko');
  final TextEditingController kantinController = TextEditingController(text: 'Kantin 1');
  final TextEditingController emailController = TextEditingController(text: 'kantin1@gmail.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    // Header: judul rata kiri
                    Row(
                      children: const [
                        Text(
                          'Edit Profil',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Foto profil bulat di tengah
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 54,
                            backgroundImage: AssetImage('assets/images/nasi_ayam.jpg'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Username
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Username', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: usernameController,
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Nama Pemilik
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Nama Pemilik', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: ownerController,
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Nama Kantin
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Nama Kantin', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: kantinController,
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Email
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Email', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: emailController,
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Simpan perubahan
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        child: const Text('Simpan Perubahan'),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Tombol logout di kanan atas
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(top: 8, right: 16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 