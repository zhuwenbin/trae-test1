import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/main_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/order_controller.dart';
import 'routes/app_routes.dart';
import 'routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    Get.put(CartController());
    Get.put(OrderController());

    return GetMaterialApp(
      title: '电商App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.main,
      getPages: AppPages.pages,
    );
  }
}
