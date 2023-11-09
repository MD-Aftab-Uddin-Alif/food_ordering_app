import 'package:get/get.dart';

import '../modules/about_us/about_us_binding.dart';
import '../modules/about_us/about_us_page.dart';

class AboutUsRoutes {
  AboutUsRoutes._();

  static const aboutUs = '/about-us';

  static final routes = [
    GetPage(
      name: aboutUs,
      page: () => const AboutUsPage(),
      binding: AboutUsBinding(),
    ),
  ];
}
