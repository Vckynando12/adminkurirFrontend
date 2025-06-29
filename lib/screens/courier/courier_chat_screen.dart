import 'package:flutter/material.dart';
import 'courier_chat_detail_screen.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Chat kamu', style: TextStyle(fontSize: 13, color: Colors.grey)),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              children: [
                _buildChatItem(
                  context,
                  avatar: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/orang.jpg'),
                    radius: 22,
                  ),
                  name: 'Dewi Sartika',
                  message: 'Ok, ditunggu yaa',
                  time: '09:30 WIB',
                ),
                _buildChatItem(
                  context,
                  avatar: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text('F', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                    radius: 22,
                  ),
                  name: 'Fanessa',
                  message: 'Siap diantar kak',
                  time: '09:30 WIB',
                ),
                _buildChatItem(
                  context,
                  avatar: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/penjual.png'),
                    radius: 22,
                  ),
                  name: 'Dikantin Cs.',
                  message: 'Baik, Kak',
                  time: '09:15 WIB',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(
    BuildContext context, {
    required Widget avatar,
    required String name,
    required String message,
    required String time,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourierChatDetailScreen(
              name: name,
              avatar: avatar,
              phone: name == 'Dewi Sartika' ? '088855552222' : '-',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            avatar,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(message, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
} 