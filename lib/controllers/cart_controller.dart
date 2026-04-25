import 'package:get/get.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

class CartController extends GetxController {
  final RxList<CartItem> _cartItems = <CartItem>[].obs;

  List<CartItem> get cartItems => _cartItems;

  int get cartCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _cartItems.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));

  void addToCart(Product product) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }
    Get.snackbar(
      '成功',
      '${product.name} 已添加到购物车',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
  }

  void updateQuantity(String productId, int quantity) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        removeFromCart(productId);
      } else {
        _cartItems[index].quantity = quantity;
      }
    }
  }

  void clearCart() {
    _cartItems.clear();
  }
}
