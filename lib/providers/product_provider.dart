import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Simulasi data produk
  void loadProducts() {
    _isLoading = true;
    notifyListeners();

    // Simulasi delay
    Future.delayed(const Duration(seconds: 1), () {
      _products = [
        Product(
          id: '1',
          name: 'Laptop Gaming ASUS ROG',
          description: 'Laptop gaming performa tinggi dengan GPU RTX 4060',
          price: 15000000,
          stock: 5,
          category: 'Electronics',
          images: ['https://via.placeholder.com/300x200'],
          sellerId: '1',
          createdAt: DateTime.now(),
        ),
        Product(
          id: '2',
          name: 'Smartphone Samsung Galaxy S24',
          description: 'Smartphone flagship dengan kamera 200MP',
          price: 12000000,
          stock: 10,
          category: 'Electronics',
          images: ['https://via.placeholder.com/300x200'],
          sellerId: '1',
          createdAt: DateTime.now(),
        ),
        Product(
          id: '3',
          name: 'Sepatu Nike Air Max',
          description: 'Sepatu olahraga dengan teknologi Air Max',
          price: 2500000,
          stock: 15,
          category: 'Fashion',
          images: ['https://via.placeholder.com/300x200'],
          sellerId: '1',
          createdAt: DateTime.now(),
        ),
        Product(
          id: '4',
          name: 'Tas Ransel Jansport',
          description: 'Tas ransel berkualitas tinggi untuk sekolah/kantor',
          price: 800000,
          stock: 20,
          category: 'Fashion',
          images: ['https://via.placeholder.com/300x200'],
          sellerId: '1',
          createdAt: DateTime.now(),
        ),
      ];
      _isLoading = false;
      notifyListeners();
    });
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    _products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  List<Product> searchProducts(String query) {
    return _products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
} 