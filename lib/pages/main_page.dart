import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../controllers/cart_controller.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();
    final CartController cartController = Get.find<CartController>();

    final List<Widget> pages = [
      const HomePage(),
      const CategoryPage(),
      CartPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: mainController.currentIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: mainController.currentIndex,
          onTap: mainController.changePage,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey[500],
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '首页',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              activeIcon: Icon(Icons.category),
              label: '分类',
            ),
            BottomNavigationBarItem(
              icon: Obx(
                () => Badge(
                  label: Text(
                    cartController.cartCount.toString(),
                    style: const TextStyle(fontSize: 10),
                  ),
                  isLabelVisible: cartController.cartCount > 0,
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              ),
              activeIcon: Obx(
                () => Badge(
                  label: Text(
                    cartController.cartCount.toString(),
                    style: const TextStyle(fontSize: 10),
                  ),
                  isLabelVisible: cartController.cartCount > 0,
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
              label: '购物车',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              activeIcon: Icon(Icons.person),
              label: '我的',
            ),
          ],
        ),
      ),
    );
  }
}
