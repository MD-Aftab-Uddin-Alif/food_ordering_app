import 'package:get/get.dart';

import 'complete_profile_controller.dart';

class CompleteProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteProfileController>(
      () => CompleteProfileController(),
    );
  }
}
