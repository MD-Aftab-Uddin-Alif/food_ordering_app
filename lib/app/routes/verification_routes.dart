import 'package:get/get.dart';

import '../modules/verification/verification_binding.dart';
import '../modules/verification/verification_page.dart';

class VerificationRoutes {
  VerificationRoutes._();

  static const verification = '/verification';

  static final routes = [
    GetPage(
      name: verification,
      page: () => const VerificationPage(),
      binding: VerificationBinding(),
    ),
  ];
}
