import 'package:get/get.dart';
import 'app_routes.dart';
import '../pages/main_page.dart';
import '../pages/product_detail_page.dart';
import '../pages/order_confirm_page.dart';
import '../pages/order_list_page.dart';
import '../pages/order_detail_page.dart';
import '../pages/address_list_page.dart';
import '../pages/address_edit_page.dart';

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
    GetPage(
      name: AppRoutes.orderConfirm,
      page: () => const OrderConfirmPage(),
    ),
    GetPage(
      name: AppRoutes.orderList,
      page: () => const OrderListPage(),
    ),
    GetPage(
      name: AppRoutes.orderDetail,
      page: () => const OrderDetailPage(),
    ),
    GetPage(
      name: AppRoutes.addressList,
      page: () => const AddressListPage(),
    ),
    GetPage(
      name: AppRoutes.addressEdit,
      page: () => const AddressEditPage(),
    ),
  ];
}
