import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/order.dart';
import '../controllers/cart_controller.dart';

class OrderController extends GetxController {
  final RxList<Order> _orders = <Order>[].obs;
  final Rx<OrderStatus?> _selectedOrder = Rx<OrderStatus?>(null);

  List<Order> get orders => _orders;
  
  List<Order> getOrdersByStatus(OrderStatus? status) {
    if (status == null) return _orders;
    return _orders.where((order) => order.status == status).toList();
  }

  Order? getOrderByNo(String orderNo) {
    try {
      return _orders.firstWhere((order) => order.orderNo == orderNo);
    } catch (e) {
      return null;
    }
  }

  String _generateOrderNo() {
    final now = DateTime.now();
    return 'ORD${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
  }

  Order createOrderFromCart({
    required List<CartItem> selectedItems,
    required ShippingAddress address,
  }) {
    final orderItems = selectedItems.map((cartItem) {
      return OrderItem(
        product: cartItem.product,
        quantity: cartItem.quantity,
      );
    }).toList();

    final totalPrice = selectedItems.fold(
        0.0,
        (sum, item) => sum + (item.product.price * item.quantity));

    final order = Order(
      orderNo: _generateOrderNo(),
      orderDate: DateTime.now(),
      items: orderItems,
      shippingAddress: address,
      status: OrderStatus.pendingPayment,
      totalPrice: totalPrice,
    );

    _orders.insert(0, order);
    return order;
  }

  void updateOrderStatus(String orderNo, OrderStatus newStatus) {
    final index = _orders.indexWhere((order) => order.orderNo == orderNo);
    if (index >= 0) {
      final currentOrder = _orders[index];
      _orders[index] = Order(
        orderNo: currentOrder.orderNo,
        orderDate: currentOrder.orderDate,
        items: currentOrder.items,
        shippingAddress: currentOrder.shippingAddress,
        status: newStatus,
        totalPrice: currentOrder.totalPrice,
      );
      _orders.refresh();
    }
  }
}
