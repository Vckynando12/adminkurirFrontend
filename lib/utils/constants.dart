import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF1976D2);
  static const Color accent = Color(0xFFFF9800);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color divider = Color(0xFFBDBDBD);
}

class AppSizes {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double iconSize = 24.0;
  static const double buttonHeight = 48.0;
}

class AppStrings {
  static const String appName = 'Admin Kurir';
  static const String login = 'Masuk';
  static const String logout = 'Keluar';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String name = 'Nama';
  static const String phone = 'Telepon';
  static const String address = 'Alamat';
  static const String save = 'Simpan';
  static const String cancel = 'Batal';
  static const String delete = 'Hapus';
  static const String edit = 'Edit';
  static const String add = 'Tambah';
  static const String search = 'Cari';
  static const String loading = 'Memuat...';
  static const String noData = 'Tidak ada data';
  static const String error = 'Terjadi kesalahan';
  static const String success = 'Berhasil';
  static const String confirm = 'Konfirmasi';
  static const String yes = 'Ya';
  static const String no = 'Tidak';
}

class OrderStatus {
  static const String pending = 'pending';
  static const String confirmed = 'confirmed';
  static const String shipped = 'shipped';
  static const String delivered = 'delivered';
  static const String cancelled = 'cancelled';

  static String getDisplayName(String status) {
    switch (status) {
      case pending:
        return 'Menunggu';
      case confirmed:
        return 'Dikonfirmasi';
      case shipped:
        return 'Dikirim';
      case delivered:
        return 'Terkirim';
      case cancelled:
        return 'Dibatalkan';
      default:
        return status;
    }
  }

  static Color getStatusColor(String status) {
    switch (status) {
      case pending:
        return AppColors.warning;
      case confirmed:
        return AppColors.primary;
      case shipped:
        return AppColors.accent;
      case delivered:
        return AppColors.success;
      case cancelled:
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }
}

class UserRole {
  static const String seller = 'seller';
  static const String courier = 'courier';

  static String getDisplayName(String role) {
    switch (role) {
      case seller:
        return 'Penjual';
      case courier:
        return 'Kurir';
      default:
        return role;
    }
  }
} 