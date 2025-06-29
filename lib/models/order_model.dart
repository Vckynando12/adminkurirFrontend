class Order {
  final String id;
  final String customerId;
  final String sellerId;
  final String? courierId;
  final List<OrderItem> items;
  final double totalAmount;
  final String status; // 'pending', 'confirmed', 'shipped', 'delivered', 'cancelled'
  final String shippingAddress;
  final String? trackingNumber;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Order({
    required this.id,
    required this.customerId,
    required this.sellerId,
    this.courierId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.shippingAddress,
    this.trackingNumber,
    required this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      sellerId: json['seller_id'],
      courierId: json['courier_id'],
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalAmount: json['total_amount'].toDouble(),
      status: json['status'],
      shippingAddress: json['shipping_address'],
      trackingNumber: json['tracking_number'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'seller_id': sellerId,
      'courier_id': courierId,
      'items': items.map((item) => item.toJson()).toList(),
      'total_amount': totalAmount,
      'status': status,
      'shipping_address': shippingAddress,
      'tracking_number': trackingNumber,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'price': price,
    };
  }
} 