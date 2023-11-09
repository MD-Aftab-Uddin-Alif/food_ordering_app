import 'package:get/get.dart';

import 'bkash_payment_controller.dart';

class BkashPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BkashPaymentController>(
      () => BkashPaymentController(),
    );
  }
}
