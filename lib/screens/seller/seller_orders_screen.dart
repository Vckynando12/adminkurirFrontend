import 'package:flutter/material.dart';
import '../../providers/order_provider.dart';
import '../../models/order_model.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class SellerOrdersScreen extends StatefulWidget {
  const SellerOrdersScreen({super.key});

  @override
  State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen> {
  String _selectedStatus = 'all';

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
        title: const Text('Pesanan'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Semua', 'all'),
                  const SizedBox(width: AppSizes.paddingSmall),
                  _buildFilterChip('Menunggu', OrderStatus.pending),
                  const SizedBox(width: AppSizes.paddingSmall),
                  _buildFilterChip('Dikonfirmasi', OrderStatus.confirmed),
                  const SizedBox(width: AppSizes.paddingSmall),
                  _buildFilterChip('Dikirim', OrderStatus.shipped),
                  const SizedBox(width: AppSizes.paddingSmall),
                  _buildFilterChip('Terkirim', OrderStatus.delivered),
                ],
              ),
            ),
          ),
          
          // Orders List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              itemCount: 5, // Placeholder
              itemBuilder: (context, index) {
                return _buildOrderCard(_getMockOrder(index));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String status) {
    final isSelected = _selectedStatus == status;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatus = status;
        });
      },
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingMedium),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${order.id}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingSmall),
                      Text(
                        Helpers.formatDate(order.createdAt),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMedium,
                    vertical: AppSizes.paddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: OrderStatus.getStatusColor(order.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  ),
                  child: Text(
                    OrderStatus.getDisplayName(order.status),
                    style: TextStyle(
                      color: OrderStatus.getStatusColor(order.status),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.paddingMedium),
            
            // Order Items
            ...order.items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.paddingSmall),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.productName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    '${item.quantity}x',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppSizes.paddingMedium),
                  Text(
                    Helpers.formatCurrency(item.price),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            const Divider(),
            
            // Order Footer
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total:',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        Helpers.formatCurrency(order.totalAmount),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (order.status == OrderStatus.pending) ...[
                  ElevatedButton(
                    onPressed: () {
                      _showStatusUpdateDialog(order, OrderStatus.confirmed);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Konfirmasi'),
                  ),
                ] else if (order.status == OrderStatus.confirmed) ...[
                  ElevatedButton(
                    onPressed: () {
                      _showStatusUpdateDialog(order, OrderStatus.shipped);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Kirim'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showStatusUpdateDialog(Order order, String newStatus) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Status'),
        content: Text('Apakah Anda yakin ingin mengubah status pesanan menjadi "${OrderStatus.getDisplayName(newStatus)}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              // Update order status
              Navigator.of(context).pop();
            },
            child: const Text(
              'Update',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Order _getMockOrder(int index) {
    final mockOrders = [
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
        status: OrderStatus.shipped,
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
        status: OrderStatus.confirmed,
        shippingAddress: 'Jl. Customer No. 456, Bandung',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
    
    return mockOrders[index % mockOrders.length];
  }
} 