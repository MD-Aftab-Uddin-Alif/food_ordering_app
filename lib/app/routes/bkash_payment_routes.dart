import 'package:get/get.dart';

import '../modules/bkash_payment/bkash_payment_binding.dart';
import '../modules/bkash_payment/bkash_payment_page.dart';

class BkashPaymentRoutes {
  BkashPaymentRoutes._();

  static const bkashPayment = '/bkash-payment';

  static final routes = [
    GetPage(
      name: bkashPayment,
      page: () => const BkashPaymentPage(),
      binding: BkashPaymentBinding(),
    ),
  ];
}
