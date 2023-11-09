import 'package:ePolli/app/core/widgets/custom_navigation_bar/custom_navigation_bar_page.dart';
import 'package:get/get.dart';
import 'package:ePolli/app/core/widgets/custom_navigation_bar/custom_navigation_bar_binding.dart';

class CustomNavigationBarRoutes {
  CustomNavigationBarRoutes._();

  static const customNavigationBar = '/custom-navigation-bar';

  static final routes = [
    GetPage(
      name: customNavigationBar,
      page: () => const CustomNavigationBarPage(),
      binding: CustomNavigationBarBinding(),
    ),
  ];
}
