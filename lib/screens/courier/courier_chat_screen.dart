import 'package:flutter/material.dart';

class CourierChatScreen extends StatelessWidget {
  const CourierChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Chat', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: false,
      ),
      body: const Center(
        child: Text('Belum ada chat', style: TextStyle(fontSize: 16, color: Colors.grey)),
      ),
    );
  }
} 