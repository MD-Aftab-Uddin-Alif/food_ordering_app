import 'package:get/get.dart';

import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_page.dart';

class SplashRoutes {
  SplashRoutes._();

  static const splash = '/splash';

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
  ];
}
