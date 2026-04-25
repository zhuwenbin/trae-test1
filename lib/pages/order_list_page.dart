import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';
import '../models/order.dart';
import '../routes/app_routes.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final initialStatus = Get.arguments as OrderStatus?;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '我的订单',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: OrderListContent(initialStatus: initialStatus),
    );
  }
}

class OrderListContent extends StatefulWidget {
  final OrderStatus? initialStatus;

  const OrderListContent({super.key, this.initialStatus});

  @override
  State<OrderListContent> createState() => _OrderListContentState();
}

class _OrderListContentState extends State<OrderListContent> {
  late OrderStatus? _selectedStatus;

  final List<Map<String, dynamic>> _statusTabs = [
    {'label': '全部', 'value': null},
    {'label': '待付款', 'value': OrderStatus.pendingPayment},
    {'label': '待发货', 'value': OrderStatus.pendingShipment},
    {'label': '待收货', 'value': OrderStatus.pendingReceipt},
    {'label': '已完成', 'value': OrderStatus.completed},
  ];

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.initialStatus;
  }

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrderController>();

    return Container(
      color: Colors.grey[50],
      child: Column(
        children: [
          _buildStatusTabs(),
          Expanded(
            child: Obx(
              () {
                final filteredOrders = orderController.getOrdersByStatus(_selectedStatus);

                if (filteredOrders.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return _buildOrderCard(order);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTabs() {
    return Container(
      color: Colors.white,
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _statusTabs.length,
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          final tab = _statusTabs[index];
          final isSelected = _selectedStatus == tab['value'];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedStatus = tab['value'] as OrderStatus?;
              });
            },
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tab['label'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? Colors.red : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 24,
                    height: 2,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.transparent,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            '暂无订单',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '快去购物吧~',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.orderDetail, arguments: order.orderNo);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildOrderHeader(order),
            _buildOrderProducts(order),
            _buildOrderFooter(order),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader(Order order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '订单号: ${order.orderNo}',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: order.status.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              order.status.name,
              style: TextStyle(
                fontSize: 13,
                color: order.status.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderProducts(Order order) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ...order.items.take(3).map((item) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    item.product.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, color: Colors.grey),
                      );
                    },
                  ),
                ),
              )),
          if (order.items.length > 3)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  '+${order.items.length - 3}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          const Spacer(),
          Text(
            '共${order.totalQuantity}件商品',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderFooter(Order order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[100]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _formatDate(order.orderDate),
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[500],
            ),
          ),
          Row(
            children: [
              Text(
                '订单金额: ',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '¥${order.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
