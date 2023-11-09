import 'package:get/get.dart';

import '../modules/order_placed/order_placed_binding.dart';
import '../modules/order_placed/order_placed_page.dart';

class OrderPlacedRoutes {
  OrderPlacedRoutes._();

  static const orderPlaced = '/order-placed';

  static final routes = [
    GetPage(
      name: orderPlaced,
      page: () => const OrderPlacedPage(),
      binding: OrderPlacedBinding(),
    ),
  ];
}
