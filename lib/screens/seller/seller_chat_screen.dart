import 'package:flutter/material.dart';

class SellerChatScreen extends StatefulWidget {
  const SellerChatScreen({super.key});

  @override
  State<SellerChatScreen> createState() => _SellerChatScreenState();
}

class _SellerChatScreenState extends State<SellerChatScreen> {
  bool chatOpen = false;

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
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Chat dari Pelanggan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Icon(
                        Icons.notifications_none,
                        color: Color(0xFF29B6F6),
                        size: 28,
                      ),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Card toggle chat
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chatOpen ? 'Buka Chat' : 'Tutup Chat',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Klik tombol untuk menutup chat dari pelanggan',
                            style: TextStyle(fontSize: 13, color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                    _CustomToggle(
                      value: chatOpen,
                      onChanged: (val) => setState(() => chatOpen = val),
                    ),
                  ],
                ),
              ),
            ),
            // Sisa konten (ilustrasi kosong)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/chat.png',
                      width: 160,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Belum ada chat',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Chat dengan pembeli akan muncul di sini',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const _CustomToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 26,
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        decoration: BoxDecoration(
          color: value ? const Color(0xFFB3E5FC) : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: value ? const Color(0xFF29B6F6) : Colors.grey[400]!, width: 2),
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: value ? Colors.white : Colors.grey[400],
              shape: BoxShape.circle,
              boxShadow: [
                if (value)
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