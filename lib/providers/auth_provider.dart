import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;

  // Simulasi login untuk frontend
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Simulasi delay network
    await Future.delayed(const Duration(seconds: 2));

    // Simulasi login logic
    if (email == 'seller@example.com' && password == 'password') {
      _currentUser = User(
        id: '1',
        name: 'John Seller',
        email: email,
        phone: '+6281234567890',
        role: 'seller',
        address: 'Jl. Contoh No. 123, Jakarta',
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } else if (email == 'courier@example.com' && password == 'password') {
      _currentUser = User(
        id: '2',
        name: 'Mike Courier',
        email: email,
        phone: '+6289876543210',
        role: 'courier',
        address: 'Jl. Kurir No. 456, Jakarta',
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _error = 'Email atau password salah';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    // Simulasi delay
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = null;
    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Login tanpa kredensial, hanya set user dummy sesuai role
  Future<void> loginTanpaKredensial(String role) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    if (role == 'seller') {
      _currentUser = User(
        id: '1',
        name: 'John Seller',
        email: 'seller@example.com',
        phone: '+6281234567890',
        role: 'seller',
        address: 'Jl. Contoh No. 123, Jakarta',
      );
    } else if (role == 'courier') {
      _currentUser = User(
        id: '2',
        name: 'Mike Courier',
        email: 'courier@example.com',
        phone: '+6289876543210',
        role: 'courier',
        address: 'Jl. Kurir No. 456, Jakarta',
      );
    }
    _isLoading = false;
    notifyListeners();
  }
} 