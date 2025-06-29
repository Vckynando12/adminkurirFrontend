import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import 'seller/seller_dashboard_screen.dart';
import 'seller/seller_products_screen.dart';
import 'seller/seller_orders_screen.dart';
import 'seller/seller_profile_screen.dart';
import 'seller/seller_chat_screen.dart';
import 'courier/courier_dashboard_screen.dart';
import 'courier/courier_profile_screen.dart';
import 'courier/courier_history_screen.dart';
import 'courier/courier_chat_screen.dart';
import 'seller/seller_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.currentUser;
        if (user == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (user.role == UserRole.seller) {
          return _buildSellerHome();
        } else {
          return _buildCourierHome();
        }
      },
    );
  }

  Widget _buildSellerHome() {
    final List<Widget> sellerScreens = [
      const SellerDashboardScreen(),
      const SellerChatScreen(),
      const SellerOrdersScreen(),
      const SellerHistoryScreen(),
      const SellerProfileScreen(),
    ];

    final List<BottomNavigationBarItem> sellerItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Beranda',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.chat_bubble_outline),
        label: 'Chat',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag),
        label: 'Pesanan',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.receipt_long),
        label: 'Riwayat',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profil',
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: sellerScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        showUnselectedLabels: true,
        items: sellerItems,
      ),
    );
  }

  Widget _buildCourierHome() {
    final List<Widget> courierScreens = [
      const CourierDashboardScreen(),
      const CourierHistoryScreen(),
      const CourierChatScreen(),
      const CourierProfileScreen(),
    ];

    final List<BottomNavigationBarItem> courierItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.list_alt),
        label: 'Pesanan',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'Riwayat',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: 'Chat',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profil',
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: courierScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: courierItems,
      ),
    );
  }
} 