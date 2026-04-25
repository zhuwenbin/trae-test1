import 'package:flutter/material.dart';
import 'product.dart';

enum OrderStatus {
  pendingPayment,
  pendingShipment,
  pendingReceipt,
  completed,
}

extension OrderStatusExtension on OrderStatus {
  String get name {
    switch (this) {
      case OrderStatus.pendingPayment:
        return '待付款';
      case OrderStatus.pendingShipment:
        return '待发货';
      case OrderStatus.pendingReceipt:
        return '待收货';
      case OrderStatus.completed:
        return '已完成';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pendingPayment:
        return Colors.orange;
      case OrderStatus.pendingShipment:
        return Colors.blue;
      case OrderStatus.pendingReceipt:
        return Colors.lightBlue;
      case OrderStatus.completed:
        return Colors.green;
    }
  }
}

class OrderItem {
  final Product product;
  final int quantity;

  OrderItem({
    required this.product,
    required this.quantity,
  });
}

class ShippingAddress {
  final String name;
  final String phone;
  final String province;
  final String city;
  final String district;
  final String detail;

  ShippingAddress({
    required this.name,
    required this.phone,
    required this.province,
    required this.city,
    required this.district,
    required this.detail,
  });

  String get fullAddress => '$province$city$district$detail';

  static ShippingAddress getDefaultAddress() {
    return ShippingAddress(
      name: '张三',
      phone: '138****8888',
      province: '广东省',
      city: '深圳市',
      district: '南山区',
      detail: '科技园路123号 创意大厦A栋1001室',
    );
  }
}

class Order {
  final String orderNo;
  final DateTime orderDate;
  final List<OrderItem> items;
  final ShippingAddress shippingAddress;
  final OrderStatus status;
  final double totalPrice;

  Order({
    required this.orderNo,
    required this.orderDate,
    required this.items,
    required this.shippingAddress,
    required this.status,
    required this.totalPrice,
  });

  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);
}
