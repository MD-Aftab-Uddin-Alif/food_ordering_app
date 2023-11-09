import 'package:get/get.dart';

import '../modules/terms_conditions/terms_conditions_binding.dart';
import '../modules/terms_conditions/terms_conditions_page.dart';

class TermsConditionsRoutes {
  TermsConditionsRoutes._();

  static const termsConditions = '/terms-conditions';

  static final routes = [
    GetPage(
      name: termsConditions,
      page: () => const TermsConditionsPage(),
      binding: TermsConditionsBinding(),
    ),
  ];
}
