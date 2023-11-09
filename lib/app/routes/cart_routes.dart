import 'package:get/get.dart';

import '../modules/cart/cart_binding.dart';
import '../modules/cart/cart_page.dart';

class CartRoutes {
  CartRoutes._();

  static const cart = '/cart';

  static final routes = [
    GetPage(
      name: cart,
      page: () => const CartPage(),
      binding: CartBinding(),
    ),
  ];
}
