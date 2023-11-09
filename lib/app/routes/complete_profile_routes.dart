import 'package:get/get.dart';

import '../modules/complete_profile/complete_profile_binding.dart';
import '../modules/complete_profile/complete_profile_page.dart';

class CompleteProfileRoutes {
  CompleteProfileRoutes._();

  static const completeProfile = '/complete-profile';

  static final routes = [
    GetPage(
      name: completeProfile,
      page: () => const CompleteProfilePage(),
      binding: CompleteProfileBinding(),
    ),
  ];
}
