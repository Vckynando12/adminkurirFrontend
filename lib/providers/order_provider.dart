import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Simulasi data pesanan
  void loadOrders() {
    _isLoading = true;
    notifyListeners();

    // Simulasi delay
    Future.delayed(const Duration(seconds: 1), () {
      _orders = [
        Order(
          id: '1',
          customerId: 'customer1',
          sellerId: '1',
          courierId: '2',
          items: [
            OrderItem(
              productId: '1',
              productName: 'Laptop Gaming ASUS ROG',
              quantity: 1,
              price: 15000000,
            ),
          ],
          totalAmount: 15000000,
          status: 'shipped',
          shippingAddress: 'Jl. Customer No. 789, Jakarta',
          trackingNumber: 'TRK001',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Order(
          id: '2',
          customerId: 'customer2',
          sellerId: '1',
          courierId: null,
          items: [
            OrderItem(
              productId: '2',
              productName: 'Smartphone Samsung Galaxy S24',
              quantity: 1,
              price: 12000000,
            ),
            OrderItem(
              productId: '3',
              productName: 'Sepatu Nike Air Max',
              quantity: 2,
              price: 2500000,
            ),
          ],
          totalAmount: 17000000,
          status: 'confirmed',
          shippingAddress: 'Jl. Customer No. 456, Bandung',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Order(
          id: '3',
          customerId: 'customer3',
          sellerId: '1',
          courierId: '2',
          items: [
            OrderItem(
              productId: '4',
              productName: 'Tas Ransel Jansport',
              quantity: 1,
              price: 800000,
            ),
          ],
          totalAmount: 800000,
          status: 'delivered',
          shippingAddress: 'Jl. Customer No. 123, Surabaya',
          trackingNumber: 'TRK002',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
      ];
      _isLoading = false;
      notifyListeners();
    });
  }

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String status) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      final order = _orders[index];
      _orders[index] = Order(
        id: order.id,
        customerId: order.customerId,
        sellerId: order.sellerId,
        courierId: order.courierId,
        items: order.items,
        totalAmount: order.totalAmount,
        status: status,
        shippingAddress: order.shippingAddress,
        trackingNumber: order.trackingNumber,
        createdAt: order.createdAt,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  void assignCourier(String orderId, String courierId) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      final order = _orders[index];
      _orders[index] = Order(
        id: order.id,
        customerId: order.customerId,
        sellerId: order.sellerId,
        courierId: courierId,
        items: order.items,
        totalAmount: order.totalAmount,
        status: order.status,
        shippingAddress: order.shippingAddress,
        trackingNumber: order.trackingNumber,
        createdAt: order.createdAt,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  List<Order> getOrdersByStatus(String status) {
    return _orders.where((order) => order.status == status).toList();
  }

  List<Order> getOrdersBySeller(String sellerId) {
    return _orders.where((order) => order.sellerId == sellerId).toList();
  }

  List<Order> getOrdersByCourier(String courierId) {
    return _orders.where((order) => order.courierId == courierId).toList();
  }
} 