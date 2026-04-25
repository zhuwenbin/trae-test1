import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '购物车',
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
      body: Container(
        color: Colors.grey[50],
        child: Obx(
          () {
            if (cartController.cartItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '购物车是空的',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '快去挑选心仪的商品吧~',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartController.cartItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                value: cartItem.isSelected.value,
                                onChanged: (value) {
                                  cartController.toggleSelection(cartItem.product.id);
                                },
                                activeColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                cartItem.product.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.image, color: Colors.grey),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.product.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '¥${cartItem.product.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              cartController.updateQuantity(
                                                cartItem.product.id,
                                                cartItem.quantity - 1,
                                              );
                                            },
                                            child: Container(
                                              width: 28,
                                              height: 28,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: const Icon(Icons.remove, size: 16),
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            height: 28,
                                            alignment: Alignment.center,
                                            child: Text(
                                              cartItem.quantity.toString(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              cartController.updateQuantity(
                                                cartItem.product.id,
                                                cartItem.quantity + 1,
                                              );
                                            },
                                            child: Container(
                                              width: 28,
                                              height: 28,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: const Icon(Icons.add, size: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: cartController.isAllSelected,
                            onChanged: (value) {
                              cartController.toggleSelectAll();
                            },
                            activeColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const Text(
                          '全选',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  '合计:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Obx(
                                  () => Text(
                                    '¥${cartController.totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Obx(
                              () => Text(
                                '已选 ${cartController.cartItems.where((item) => item.isSelected.value).length} 件商品',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 100,
                          height: 44,
                          child: Obx(
                            () => ElevatedButton(
                              onPressed: cartController.cartItems
                                      .where((item) => item.isSelected.value)
                                      .isEmpty
                                  ? null
                                  : () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                disabledBackgroundColor: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              child: Text(
                                '结算',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: cartController.cartItems
                                          .where((item) => item.isSelected.value)
                                          .isEmpty
                                      ? Colors.grey[500]
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
