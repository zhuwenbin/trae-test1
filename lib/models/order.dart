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
  final String id;
  final String name;
  final String phone;
  final String province;
  final String city;
  final String district;
  final String detail;
  final bool isDefault;

  ShippingAddress({
    required this.id,
    required this.name,
    required this.phone,
    required this.province,
    required this.city,
    required this.district,
    required this.detail,
    this.isDefault = false,
  });

  String get fullAddress => '$province$city$district$detail';

  String get maskedPhone {
    if (phone.length == 11) {
      return '${phone.substring(0, 3)}****${phone.substring(7)}';
    }
    return phone;
  }

  ShippingAddress copyWith({
    String? id,
    String? name,
    String? phone,
    String? province,
    String? city,
    String? district,
    String? detail,
    bool? isDefault,
  }) {
    return ShippingAddress(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      province: province ?? this.province,
      city: city ?? this.city,
      district: district ?? this.district,
      detail: detail ?? this.detail,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'province': province,
      'city': city,
      'district': district,
      'detail': detail,
      'isDefault': isDefault,
    };
  }

  static ShippingAddress fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      province: json['province'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
      detail: json['detail'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
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
