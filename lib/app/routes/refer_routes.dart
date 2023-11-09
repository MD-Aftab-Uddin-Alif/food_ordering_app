import 'package:get/get.dart';

import '../modules/refer/refer_binding.dart';
import '../modules/refer/refer_page.dart';

class ReferRoutes {
  ReferRoutes._();

  static const refer = '/refer';

  static final routes = [
    GetPage(
      name: refer,
      page: () => const ReferPage(),
      binding: ReferBinding(),
    ),
  ];
}
