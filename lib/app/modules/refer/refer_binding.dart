import 'package:get/get.dart';

import 'refer_controller.dart';

class ReferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferController>(
      () => ReferController(),
    );
  }
}
