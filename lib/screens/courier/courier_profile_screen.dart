import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class CourierProfileScreen extends StatelessWidget {
  const CourierProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.currentUser;
        if (user == null) return const SizedBox.shrink();

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('Profil'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Navigate to edit profile
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            child: Column(
              children: [
                // Profile Header
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
                    children: [
                      // Profile Picture
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: user.profileImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  user.profileImage!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.person,
                                      size: 50,
                                      color: AppColors.accent,
                                    );
                                  },
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.accent,
                              ),
                      ),
                      const SizedBox(height: AppSizes.paddingMedium),
                      
                      // User Info
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingSmall),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingSmall),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingMedium,
                          vertical: AppSizes.paddingSmall,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                        ),
                        child: Text(
                          UserRole.getDisplayName(user.role),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.paddingLarge),

                // Profile Details
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingMedium),
                    child: Column(
                      children: [
                        _buildProfileItem(
                          context,
                          icon: Icons.phone,
                          title: 'Telepon',
                          value: user.phone,
                        ),
                        const Divider(),
                        _buildProfileItem(
                          context,
                          icon: Icons.location_on,
                          title: 'Alamat',
                          value: user.address ?? 'Tidak ada alamat',
                        ),
                        const Divider(),
                        _buildProfileItem(
                          context,
                          icon: Icons.email,
                          title: 'Email',
                          value: user.email,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingLarge),

                // Performance Stats
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
                          'Statistik Performa',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingMedium),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatItem(
                                context,
                                'Pengiriman Hari Ini',
                                '5',
                                Icons.local_shipping,
                                AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppSizes.paddingMedium),
                            Expanded(
                              child: _buildStatItem(
                                context,
                                'Total Pengiriman',
                                '127',
                                Icons.check_circle,
                                AppColors.success,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.paddingMedium),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatItem(
                                context,
                                'Pendapatan Hari Ini',
                                'Rp 75.000',
                                Icons.attach_money,
                                AppColors.accent,
                              ),
                            ),
                            const SizedBox(width: AppSizes.paddingMedium),
                            Expanded(
                              child: _buildStatItem(
                                context,
                                'Rating',
                                '4.9',
                                Icons.star,
                                AppColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingLarge),

                // Vehicle Info
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
                              Icons.motorcycle,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            const SizedBox(width: AppSizes.paddingSmall),
                            Text(
                              'Informasi Kendaraan',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.paddingMedium),
                        _buildProfileItem(
                          context,
                          icon: Icons.motorcycle,
                          title: 'Jenis Kendaraan',
                          value: 'Motor Honda PCX 160',
                        ),
                        const Divider(),
                        _buildProfileItem(
                          context,
                          icon: Icons.confirmation_number,
                          title: 'Nomor Plat',
                          value: 'B 1234 ABC',
                        ),
                        const Divider(),
                        _buildProfileItem(
                          context,
                          icon: Icons.color_lens,
                          title: 'Warna',
                          value: 'Hitam',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingLarge),

                // Actions
                CustomButton(
                  onPressed: () {
                    // Navigate to settings
                  },
                  text: 'Pengaturan',
                  icon: Icons.settings,
                  backgroundColor: AppColors.textSecondary,
                ),
                const SizedBox(height: AppSizes.paddingMedium),
                CustomButton(
                  onPressed: () async {
                    await authProvider.logout();
                    if (context.mounted) {
                      Navigator.of(context).pushReplacementNamed('/login');
                    }
                  },
                  text: 'Keluar',
                  icon: Icons.logout,
                  backgroundColor: AppColors.error,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingSmall),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(width: AppSizes.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: AppSizes.paddingSmall),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
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