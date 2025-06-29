import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../widgets/custom_button.dart';

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
      appBar: AppBar(
        title: const Text('Dashboard Penjual'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer3<AuthProvider, OrderProvider, ProductProvider>(
        builder: (context, authProvider, orderProvider, productProvider, child) {
          final user = authProvider.currentUser;
          if (user == null) return const SizedBox.shrink();

          final sellerOrders = orderProvider.getOrdersBySeller(user.id);
          final pendingOrders = sellerOrders.where((order) => order.status == OrderStatus.pending).length;
          final confirmedOrders = sellerOrders.where((order) => order.status == OrderStatus.confirmed).length;
          final shippedOrders = sellerOrders.where((order) => order.status == OrderStatus.shipped).length;
          final totalProducts = productProvider.products.length;
          final lowStockProducts = productProvider.products.where((product) => product.stock < 5).length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.paddingLarge),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang,',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingSmall),
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingSmall),
                      Text(
                        '${UserRole.getDisplayName(user.role)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.paddingLarge),

                // Statistics Grid
                Text(
                  'Statistik Hari Ini',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingMedium),
                
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSizes.paddingMedium,
                  mainAxisSpacing: AppSizes.paddingMedium,
                  childAspectRatio: 1.5,
                  children: [
                    _buildStatCard(
                      'Pesanan Menunggu',
                      pendingOrders.toString(),
                      Icons.pending,
                      AppColors.warning,
                    ),
                    _buildStatCard(
                      'Pesanan Dikonfirmasi',
                      confirmedOrders.toString(),
                      Icons.check_circle,
                      AppColors.primary,
                    ),
                    _buildStatCard(
                      'Pesanan Dikirim',
                      shippedOrders.toString(),
                      Icons.local_shipping,
                      AppColors.accent,
                    ),
                    _buildStatCard(
                      'Total Produk',
                      totalProducts.toString(),
                      Icons.inventory,
                      AppColors.success,
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.paddingLarge),

                // Quick Actions
                Text(
                  'Aksi Cepat',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingMedium),
                
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          // Navigate to add product
                        },
                        text: 'Tambah Produk',
                        icon: Icons.add,
                        backgroundColor: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingMedium),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          // Navigate to orders
                        },
                        text: 'Lihat Pesanan',
                        icon: Icons.shopping_cart,
                        backgroundColor: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.paddingLarge),

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
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          const SizedBox(height: AppSizes.paddingSmall),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.paddingSmall),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 