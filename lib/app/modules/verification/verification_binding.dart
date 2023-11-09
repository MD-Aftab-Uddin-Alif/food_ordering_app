import 'package:get/get.dart';

import 'verification_controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationController>(
      () => VerificationController(),
    );
  }
}
