import 'package:get/get.dart';

import '../modules/checkout/checkout_binding.dart';
import '../modules/checkout/checkout_page.dart';

class CheckoutRoutes {
  CheckoutRoutes._();

  static const checkout = '/checkout';

  static final routes = [
    GetPage(
      name: checkout,
      page: () => const CheckoutPage(),
      binding: CheckoutBinding(),
    ),
  ];
}
