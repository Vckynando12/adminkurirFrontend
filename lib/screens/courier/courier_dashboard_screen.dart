import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class CourierDashboardScreen extends StatefulWidget {
  const CourierDashboardScreen({super.key});

  @override
  State<CourierDashboardScreen> createState() => _CourierDashboardScreenState();
}

class _CourierDashboardScreenState extends State<CourierDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load orders
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Dashboard Kurir'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.currentUser;
          if (user == null) return const SizedBox.shrink();

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
                      colors: [AppColors.accent, AppColors.warning],
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
                        'Siap mengantarkan pesanan hari ini?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.paddingLarge),

                // Today's Stats
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
                      'Pesanan Diterima',
                      '3',
                      Icons.assignment,
                      AppColors.primary,
                    ),
                    _buildStatCard(
                      'Dalam Pengiriman',
                      '2',
                      Icons.local_shipping,
                      AppColors.accent,
                    ),
                    _buildStatCard(
                      'Selesai Dikirim',
                      '8',
                      Icons.check_circle,
                      AppColors.success,
                    ),
                    _buildStatCard(
                      'Pendapatan',
                      'Rp 150.000',
                      Icons.attach_money,
                      AppColors.warning,
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.paddingLarge),

                // Current Location
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            const SizedBox(width: AppSizes.paddingSmall),
                            Text(
                              'Lokasi Saat Ini',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.paddingMedium),
                        Text(
                          'Jakarta Selatan, DKI Jakarta',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingMedium),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  // Update location
                                },
                                text: 'Update Lokasi',
                                icon: Icons.my_location,
                                backgroundColor: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppSizes.paddingMedium),
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  // View map
                                },
                                text: 'Lihat Peta',
                                icon: Icons.map,
                                backgroundColor: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                          // Navigate to available orders
                        },
                        text: 'Pesanan Tersedia',
                        icon: Icons.list_alt,
                        backgroundColor: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingMedium),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          // Navigate to my deliveries
                        },
                        text: 'Pengiriman Saya',
                        icon: Icons.local_shipping,
                        backgroundColor: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.paddingLarge),

                // Status Toggle
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status Kerja',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                                  // Set available status
                                },
                                text: 'Tersedia',
                                icon: Icons.check_circle,
                                backgroundColor: AppColors.success,
                              ),
                            ),
                            const SizedBox(width: AppSizes.paddingMedium),
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  // Set busy status
                                },
                                text: 'Sibuk',
                                icon: Icons.pause_circle,
                                backgroundColor: AppColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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