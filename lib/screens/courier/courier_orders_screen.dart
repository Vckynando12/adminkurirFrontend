import 'package:flutter/material.dart';
import '../../providers/order_provider.dart';
import '../../models/order_model.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class CourierOrdersScreen extends StatefulWidget {
  const CourierOrdersScreen({super.key});

  @override
  State<CourierOrdersScreen> createState() => _CourierOrdersScreenState();
}

class _CourierOrdersScreenState extends State<CourierOrdersScreen> {
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
        title: const Text('Pengiriman'),
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
                  _buildFilterChip('Diterima', OrderStatus.shipped),
                  const SizedBox(width: AppSizes.paddingSmall),
                  _buildFilterChip('Dalam Perjalanan', 'in_transit'),
                  const SizedBox(width: AppSizes.paddingSmall),
                  _buildFilterChip('Selesai', OrderStatus.delivered),
                ],
              ),
            ),
          ),
          
          // Orders List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              itemCount: 3, // Placeholder
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
            
            // Delivery Info
            Container(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSizes.paddingSmall),
                      Text(
                        'Alamat Pengiriman:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingSmall),
                  Text(
                    order.shippingAddress,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.paddingMedium),
            
            // Order Items
            Text(
              'Item Pesanan:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSizes.paddingSmall),
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
                if (order.status == OrderStatus.shipped) ...[
                  ElevatedButton(
                    onPressed: () {
                      _showDeliveryDialog(order);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Terima Pesanan'),
                  ),
                ] else if (order.status == 'in_transit') ...[
                  ElevatedButton(
                    onPressed: () {
                      _showDeliveryCompleteDialog(order);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Selesai Kirim'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeliveryDialog(Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terima Pesanan'),
        content: const Text('Apakah Anda yakin ingin menerima pesanan ini untuk dikirim?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              // Accept delivery
              Navigator.of(context).pop();
            },
            child: const Text(
              'Terima',
              style: TextStyle(color: AppColors.success),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeliveryCompleteDialog(Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selesai Pengiriman'),
        content: const Text('Apakah pesanan telah berhasil dikirim ke pelanggan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              // Complete delivery
              Navigator.of(context).pop();
            },
            child: const Text(
              'Selesai',
              style: TextStyle(color: AppColors.success),
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
        shippingAddress: 'Jl. Customer No. 789, Jakarta Selatan',
        trackingNumber: 'TRK001',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Order(
        id: '2',
        customerId: 'customer2',
        sellerId: '1',
        courierId: '2',
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
        status: 'in_transit',
        shippingAddress: 'Jl. Customer No. 456, Jakarta Pusat',
        trackingNumber: 'TRK002',
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
        status: OrderStatus.delivered,
        shippingAddress: 'Jl. Customer No. 123, Jakarta Barat',
        trackingNumber: 'TRK003',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
    
    return mockOrders[index % mockOrders.length];
  }
} 