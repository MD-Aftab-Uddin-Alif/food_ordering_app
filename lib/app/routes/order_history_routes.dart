import 'package:get/get.dart';

import '../modules/order_history/order_history_binding.dart';
import '../modules/order_history/order_history_page.dart';

class OrderHistoryRoutes {
  OrderHistoryRoutes._();

  static const orderHistory = '/order-history';

  static final routes = [
    GetPage(
      name: orderHistory,
      page: () => OrderHistoryPage(),
      binding: OrderHistoryBinding(),
    ),
  ];
}
