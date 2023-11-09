import 'package:get/get.dart';

import '../modules/more/more_binding.dart';
import '../modules/more/more_page.dart';

class MoreRoutes {
  MoreRoutes._();

  static const more = '/more';

  static final routes = [
    GetPage(
      name: more,
      page: () => const MorePage(),
      binding: MoreBinding(),
    ),
  ];
}
