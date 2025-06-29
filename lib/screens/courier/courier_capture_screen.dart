import 'package:flutter/material.dart';

class CourierCaptureScreen extends StatelessWidget {
  const CourierCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Foto Bukti Pengantaran', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          // Preview kamera dummy
          Expanded(
            child: Center(
              child: Container(
                width: 260,
                height: 360,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                ),
                child: Center(
                  child: Image.asset('assets/images/barcode.png', width: 200, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Tombol capture
          Center(
            child: Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.camera, color: Colors.white, size: 36),
                onPressed: () {
                  // Aksi ambil foto (dummy)
                },
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
} 