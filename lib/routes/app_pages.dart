import 'package:get/get.dart';
import 'app_routes.dart';
import '../pages/main_page.dart';
import '../pages/product_detail_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailPage(),
    ),
  ];
}
